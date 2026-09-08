# Extending Pulumi Neo — walkthrough

Give Neo access to the systems your incidents actually live in: SaaS tools over
MCP integrations, cloud accounts over CLI integrations backed by Pulumi ESC.
These are the three things typed on stage, and you can run the same flow against
your own org. Everything else in the session is a recorded clip or a click into a
real pull request; those are listed at the end.

**Estimated time**: 30 minutes (plus one-time setup)

Commands are written for the demo org, `adamgordonbell-org` — swap in your own
org name throughout.

## Prerequisites

```
- Pulumi CLI v3.254.0+
- A Pulumi organization with Neo (the Context API query needs Enterprise / Business Critical)
- An AWS account you can deploy into, plus a CLI profile that reaches it
- GitHub: the Pulumi GitHub App installed, with access to your fork of the incident repo
- PagerDuty: a free 14-day trial — sign up as a dedicated bot user; mint an API token
- Linear: a free workspace with one open ticket (e.g. "Add versioning to the staging bucket")
  and a personal API key
```

Connect the integrations in the Pulumi console — **Settings → Neo → Integrations**:

```
MCP tools:   PagerDuty (your bot user's token), Linear (your API key)
CLI tools:   aws → an ESC environment. Scope it as narrowly as you are comfortable with;
             a read-only role means the pull request is the only write path.
             (reasoning: docs/credentials.md; esc-readonly-role/ in the incident repo)
```

## Setup

Two repos. This one holds the walkthrough, the slides, and the Context API
queries; everything runnable lives in the incident repo, checked out at
`demo/pulumi-ts` (its own git repo, gitignored here). Neo opens its fix PRs
against that repo, so if you are following along in your own org, **fork it**
and clone your fork there instead:

```bash
cd extending-pulumi-neo/demo/pulumi-ts   # or: git clone <your fork> demo/pulumi-ts
npm install
pulumi stack select adamgordonbell-org/dev   # first time: pulumi stack init adamgordonbell-org/dev
```

First-time stack config (already set on the demo stack):

```bash
pulumi config set aws:region ca-central-1
pulumi config set --secret pagerduty:token   # paste your PagerDuty API token
pulumi config set pagerdutyEmail you@example.com   # where the page lands — a real inbox
```

The token here is for the **Pulumi provider** — `pulumi up` uses it to create the
team, schedule, and service. It is separate from the Integrations page, which
hands the (same) token to **Neo** for reading incidents mid-task. Both are needed.

Deploy the payment pipeline Neo will diagnose, plus the entire PagerDuty side
(team, rotation, escalation policy, service, CloudWatch integration):

```bash
pulumi up                # ~5 min; the RDS instance is the slow part
./add-db-sg.sh           # the fault that is NOT in the program (see below)
./prewarm.sh             # 9 checks, all must be ok
pulumi stack --show-urns | grep -i security   # expect nothing
```

The program carries three deliberate faults, written up in
[`docs/FINDINGS.md`](docs/FINDINGS.md) here, not in the incident repo: nothing in
Neo's working directory names them. `add-db-sg.sh` plants a fourth one outside
the program: a security group open to the world on 5432, created with the raw
aws CLI and attached to the database, standing in for "somebody opened the
console at 2am and never came back." Nothing in Pulumi state describes it, so Neo
can only find it by reading the live account. `cleanup.sh` removes it again.

## 1. What it knows — one query against the Context API

One read-only query against the resource graph. From the workshop repo:

```bash
cd extending-pulumi-neo/demo/context-api
cat coverage-by-tool.json
```

```json
{
  "anchor": { "nodeType": "resource", "limit": 25 },
  "aggregate": {
    "groupBy": ["managed"],
    "metrics": [{ "op": "count", "alias": "n" }]
  }
}
```

```bash
pulumi api GraphQuery -F orgName=adamgordonbell-org --input coverage-by-tool.json
```

```json
"aggregations": { "buckets": [
  { "key": { "managed": "Other"  }, "metrics": { "n": 1305 } },
  { "key": { "managed": "Pulumi" }, "metrics": { "n":  144 } } ] }
```

About 90% of this account is not managed by Pulumi, and Neo can now reason about
all of it. Two more queries, same shape:

```bash
pulumi api GraphQuery -F orgName=adamgordonbell-org --input unmanaged-by-type.json
pulumi api GraphQuery -F orgName=adamgordonbell-org --input unmanaged-security-groups.json
```

Then the same graph in natural language. Neo writes and runs the selector itself:

```bash
pulumi neo --org adamgordonbell-org
```

Ask, in this order; each one is a question the launch post says the graph exists to answer:

| Ask Neo | What comes back (verified Sep 8, stack destroyed) |
|---|---|
| **Coverage** — "From what Pulumi knows about my org, how much of my AWS account does Pulumi actually manage, and what kinds of things are outside it?" | Pulumi 144 / Other 1305; CloudFront distributions, cache policies, OAIs lead the unmanaged pile |
| **Impact** — "Which of my resources are still managed by an AWS provider older than 7.0, and in which stacks?" | With the payments stack up: the whole pipeline (`@pulumi/aws` is pinned to 6.83) plus the 50 momentum-infra resources on 6.x |
| **Cleanup** — "In the neo-workshop-incident stack, which resources does nothing else depend on? What could I change first?" | The dependency leaves: `target.absent` on inbound `reference` edges |
| **Tie-in** — "Which security groups in my account are not managed by Pulumi?" | 3 on Aug 27. Whether the planted one shows depends on scan lag; either way is a beat (see README) |

Say "from what Pulumi knows" or "using the Context API": with the aws CLI
connected, Neo will otherwise happily answer the last two with `aws ec2 describe-*`
and never touch the graph. Skip the post's "which stacks consume outputs from
payments/prod": this org has zero cross-stack edges, so it returns nothing.
The selectors Neo should arrive at are in `demo/context-api/` as files, so the
typed and the asked forms can be compared on screen.

Full write-up + a curl form for older CLIs: [`demo/context-api/README.md`](demo/context-api/README.md).

## Tour — the thing Neo is about to work on (slide 14, while triggering)

Slide 14 carries the orange cue. Run the trigger from the `pulumi-ts` terminal,
then give the two-minute tour while the page is on its way. Order: code, Pulumi
Cloud, AWS, then the two tools.

```bash
cd extending-pulumi-neo/demo/pulumi-ts
./trigger-incident.sh        # page lands in ~3 min; 30-min auto-resolve clock starts
```

**The line:** a payments service. Messages go on a queue; anything that fails to
process lands in a dead-letter queue; a CloudWatch alarm watches that queue and,
through SNS, pages me in PagerDuty. A Postgres database and a staging bucket sit
next to it. One Pulumi program stands up all of it, PagerDuty side included.

1. **The program** — `index.ts` in the editor. Scroll once: queue + DLQ, the two
   alarms, SNS → PagerDuty, the bucket, the RDS instance, and the PagerDuty team,
   schedule, escalation policy and service. Do not linger on the redrive policy.
2. **Pulumi Cloud** — the stack, 16 resources, and the resource graph:
   <https://app.pulumi.com/adamgordonbell-org/neo-workshop-incident/dev>
   (Resources tab → graph view). This is what Neo already knew.
3. **AWS** — "this is a real account, not a mock." Two clicks:
   - RDS: <https://ca-central-1.console.aws.amazon.com/rds/home?region=ca-central-1#database:id=payments-db3a72bce;is-cluster=false>
   - SQS: <https://ca-central-1.console.aws.amazon.com/sqs/v3/home?region=ca-central-1#/queues>
   Do not open the security-group tab on the database.
4. **PagerDuty** — a real on-call setup, service `payments`, and the incident list
   where the page will land: <https://pulumi-bot-test.pagerduty.com/incidents>
5. **Linear** — a real tracker with one ticket waiting:
   <https://linear.app/agb-demo-test/issue/PUL-5/add-versioning-to-the-staging-bucket>

Then slide 15. The page arrives during 15–16; let the phone buzz.

## 2. What it can reach — a Linear ticket becomes a PR

With the Linear MCP connected and a ticket waiting, hand Neo the ticket. From
the incident checkout:

```bash
cd extending-pulumi-neo/demo/pulumi-ts   # Pulumi.yaml + the git remote live here — Neo needs both
git checkout main
pulumi neo
```

> Pick up the open Linear ticket about the staging bucket, make the change in
> this program, and open a PR. Comment back on the ticket with the PR link.

Neo reads the ticket over MCP, plans against the real stack, opens the PR, and
comments back on the ticket. Nothing was pasted. About 4½ minutes end to end
(Sep 4). Neo leaves the checkout on its feature branch; `git checkout main`
before the next demo.

Use the interactive `pulumi neo`, not `pulumi neo -p`. Print mode exits the
first time the agent marks a message final, which today happened mid-task on
both attempts of the incident demo.

## 3. What it can reach — a PagerDuty incident, end to end

Cause a real page. The script sends a poison payment message, then plays the
failing consumer:

```bash
cd extending-pulumi-neo/demo/pulumi-ts
./trigger-incident.sh        # incident opens ~3 min later
```

When the page arrives (check your PagerDuty service and your inbox), hand the
incident to Neo:

```bash
git checkout main
pulumi neo
```

> We're getting paged. Check PagerDuty for the open incident, find out why
> payment messages are dead-lettering, and fix the cause in this program.
> While you are in the account, check whether anything attached to the
> database is running that this program doesn't describe. Open a PR.

Neo reads the incident over the PagerDuty MCP, reads live queue state through
the `aws` CLI integration, and lands on fault 1 — `maxReceiveCount: 1`, no
retry, every transient failure dead-letters. The second sentence of the prompt
is what sends it to the planted security group; without it, Neo stays inside
the program. Expect it to report the open rule and the mitigating factor (the
database is not publicly accessible), and to adopt and narrow the group in the
same PR rather than delete it. The fix arrives as a PR on your fork; the
incident resolves back in PagerDuty.

Timing and the two questions (Sep 4 run): 10½ minutes from prompt to PR.
Neo stops twice to ask. After about 4 minutes it lays out its plan and asks
"Proceed?" — answer **yes**. After the preview it asks whether to `pulumi up`
or just open the PR — answer **skip the deploy, open the PR**. Deploying
would fix the fault for real and un-plant the demo.

Reset between runs:

```bash
./cleanup.sh                 # purge queues → alarm OK → incident auto-resolves; removes the planted security group
./add-db-sg.sh        # re-plant it before the next run
git checkout main
```

Never merge the fix PR: merging un-plants the fault. Close it, or leave it
open as a receipt.

## The rest of the session: clips and real pull requests

Nothing below is typed on stage. Each is a recording or a link into a PR Neo
opened in an earlier session, so you can read the same thing the room saw.

| Beat | What it is |
|---|---|
| Narrowing IAM policies from the terminal | clip · [iam-narrow-demo#1](https://github.com/adamgordonbell/iam-narrow-demo/pull/1) |
| Scheduling a task, and the next morning's PR | clip · [neo-examples#9](https://github.com/adamgordonbell/neo-examples/pull/9) |
| The runbook decides | [neo-drift-demo#1](https://github.com/adamgordonbell/neo-drift-demo/pull/1), a drift check that cites `infra/runbooks/drift.md` |
| What it left behind | [neo-examples#7](https://github.com/adamgordonbell/neo-examples/pull/7) · [#5](https://github.com/adamgordonbell/neo-examples/pull/5) |

To reproduce the runbook one: deploy `neo-drift-demo`, add an inline policy to the
`audit-reader` role out of band, and ask Neo to run the drift check against the
runbook. The exact prompt is in `TODO.md`.

## Teardown

```bash
cd extending-pulumi-neo/demo/pulumi-ts
./cleanup.sh         # resolves open incidents and removes the planted security group first;
                     # PagerDuty refuses to delete the schedule while an incident is open
pulumi destroy       # removes the AWS chain and the PagerDuty config
pulumi stack rm dev
```

Your PagerDuty trial expires on its own; delete the Linear workspace if you
made one just for this.
