# Extending Pulumi Neo — demo walkthrough

Three demos, run live: one Context API query, a Linear ticket that becomes a pull
request, and a PagerDuty page that becomes a merged fix. Roughly 30 minutes plus
one-time setup.

Commands are written for the org `adamgordonbell-org` — substitute your own throughout.

## Prerequisites

- Pulumi CLI v3.254.0+
- A Pulumi organization with Neo (the Context API query needs Enterprise / Business Critical)
- An AWS account you can deploy into, plus a CLI profile that reaches it
- The Pulumi GitHub App installed, with access to your fork of the incident repo
- A PagerDuty account (the free 14-day trial works) — sign up a dedicated bot user and mint an API token
- A Linear workspace with one open ticket (e.g. "Add versioning to the staging bucket") and a personal API key

In the Pulumi console under **Settings → Neo → Integrations**, connect:

- **MCP:** PagerDuty (the bot user's token), Linear (your API key)
- **CLI:** `aws`, pointed at an ESC environment. Scope it as narrowly as you are
  comfortable with — with a read-only role, the pull request is the only write path.

## Setup

Everything runnable lives in the incident repo, checked out at `demo/pulumi-ts` (its own
git repo, gitignored here). Neo opens its pull requests against that repo, so fork it and
clone your fork there.

1. Install dependencies and select a stack:

    ```bash
    cd demo/pulumi-ts          # or: git clone <your fork> demo/pulumi-ts
    npm install
    pulumi stack init adamgordonbell-org/dev    # or `stack select` if it exists
    ```

2. Set the stack config. The PagerDuty token here is for the **Pulumi provider** —
   `pulumi up` uses it to create the team, schedule and service. It is separate from the
   Integrations page, which hands the same token to Neo for reading incidents mid-task.
   Both are needed.

    ```bash
    pulumi config set aws:region ca-central-1
    pulumi config set --secret pagerduty:token        # your PagerDuty API token
    pulumi config set pagerdutyEmail you@example.com  # a real inbox — the page lands here
    ```

3. Deploy the payment pipeline and the whole PagerDuty side (team, rotation, escalation
   policy, service, CloudWatch integration):

    ```bash
    pulumi up                # ~5 min; the RDS instance is the slow part
    ```

4. Plant the out-of-band fault and verify the environment:

    ```bash
    ./add-db-sg.sh                                # security group open to the world on 5432
    ./prewarm.sh                                  # 9 checks, all must be ok
    pulumi stack --show-urns | grep -i security   # expect nothing
    ```

    The program itself carries three deliberate faults. `add-db-sg.sh` plants a fourth one
    *outside* the program with the raw aws CLI, so nothing in Pulumi state describes it and
    Neo can only find it by reading the live account. `cleanup.sh` removes it again.

## Demo 1: What Neo knows — the Context API

1. Run a read-only query against the resource graph:

    ```bash
    cd demo/context-api
    pulumi api GraphQuery -F orgName=adamgordonbell-org --input coverage-by-tool.json
    ```

    ```json
    "aggregations": { "buckets": [
      { "key": { "managed": "Other"  }, "metrics": { "n": 1305 } },
      { "key": { "managed": "Pulumi" }, "metrics": { "n":  144 } } ] }
    ```

    About 90% of the account is not managed by Pulumi, and Neo can reason about all of it.

2. Run the other two queries, same shape:

    ```bash
    pulumi api GraphQuery -F orgName=adamgordonbell-org --input unmanaged-by-type.json
    pulumi api GraphQuery -F orgName=adamgordonbell-org --input unmanaged-security-groups.json
    ```

3. Ask the same questions in natural language — Neo writes and runs the selector itself:

    ```bash
    pulumi neo --org adamgordonbell-org
    ```

    | Ask Neo | What comes back |
    |---|---|
    | **Coverage** — "From what Pulumi knows about my org, how much of my AWS account does Pulumi actually manage, and what kinds of things are outside it?" | Pulumi 144 / Other 1305; CloudFront distributions, cache policies and OAIs lead the unmanaged pile |
    | **Impact** — "Which of my resources are still managed by an AWS provider older than 7.0, and in which stacks?" | The whole payments pipeline (`@pulumi/aws` pinned to 6.83), plus anything else on 6.x |
    | **Cleanup** — "In the neo-workshop-incident stack, which resources does nothing else depend on? What could I change first?" | The dependency leaves: `target.absent` on inbound `reference` edges |
    | **Tie-in** — "Which security groups in my account are not managed by Pulumi?" | The unmanaged groups, subject to scan lag |

    Say "from what Pulumi knows" or "using the Context API" — with the aws CLI connected,
    Neo will otherwise answer with `aws ec2 describe-*` and never touch the graph.

The equivalent selectors are in `demo/context-api/` as files, so the typed and the asked
forms can be compared side by side. Full write-up and a curl form for older CLIs:
[`demo/context-api/README.md`](demo/context-api/README.md).

## Demo 2: A Linear ticket becomes a pull request

1. Start Neo from the incident checkout — `Pulumi.yaml` and the git remote both live
   there, and Neo needs both. Use the interactive `pulumi neo`, not `pulumi neo -p`:
   print mode exits the first time the agent marks a message final, which happens
   mid-task.

    ```bash
    cd demo/pulumi-ts
    git checkout main
    pulumi neo
    ```

2. Give it the ticket:

    > Pick up the open Linear ticket about the staging bucket, make the change in
    > this program, and open a PR. Comment back on the ticket with the PR link.

    Neo reads the ticket over MCP, plans against the real stack, opens the pull request,
    and comments back on the ticket. Nothing is pasted.

3. Neo leaves the checkout on its feature branch. Return to `main` before the next demo:

    ```bash
    git checkout main
    ```

## Demo 3: A PagerDuty incident becomes a fix

1. Cause a real page. The script sends a poison payment message, then plays the failing
   consumer:

    ```bash
    cd demo/pulumi-ts
    ./trigger-incident.sh        # incident opens ~3 min later
    ```

2. When the page arrives — check your PagerDuty service and your inbox — hand the
   incident to Neo:

    ```bash
    git checkout main
    pulumi neo
    ```

    > We're getting paged. Check PagerDuty for the open incident, find out why
    > payment messages are dead-lettering, and fix the cause in this program.
    > While you are in the account, check whether anything attached to the
    > database is running that this program doesn't describe. Open a PR.

    Neo reads the incident over the PagerDuty MCP, reads live queue state through the
    `aws` CLI integration, and lands on fault 1 — `maxReceiveCount: 1`, no retry, so every
    transient failure dead-letters. The second sentence is what sends it to the planted
    security group; without it Neo stays inside the program. Expect it to report the open
    rule and the mitigating factor (the database is not publicly accessible), and to adopt
    and narrow the group in the same pull request rather than delete it.

3. Neo stops twice to ask. Answer **yes** to "Proceed?", and **skip the deploy, open the
   PR** when it asks whether to `pulumi up` — deploying would fix the fault for real and
   un-plant the demo.

4. Never merge the fix PR; merging un-plants the fault. Close it, or leave it open as a
   receipt.

5. Reset before running it again:

    ```bash
    ./cleanup.sh          # purge queues → alarm OK → incident auto-resolves; removes the planted security group
    ./add-db-sg.sh        # re-plant it
    git checkout main
    ```

## Teardown

```bash
cd demo/pulumi-ts
./cleanup.sh         # resolves open incidents and removes the planted security group first;
                     # PagerDuty refuses to delete the schedule while an incident is open
pulumi destroy       # removes the AWS chain and the PagerDuty config
pulumi stack rm dev
```

Your PagerDuty trial expires on its own; delete the Linear workspace if you made one
just for this.
