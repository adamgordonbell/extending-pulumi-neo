# Extending Pulumi Neo — walkthrough

Give Neo access to the systems your incidents actually live in: SaaS tools over
MCP integrations, cloud accounts over CLI integrations backed by Pulumi ESC.
This is the tutorial the live session follows — every command below gets typed
on stage, and you can run the same flow against your own org.

**Estimated time**: 60 minutes (plus one-time setup)

Commands are written for the demo org, `adamgordonbell-org` — swap in your own
org name throughout.

## Prerequisites

```
- Pulumi CLI v3.254.0+          (`pulumi api` needs 3.243+, `pulumi neo acp` needs 3.254+)
- A Pulumi organization with Neo (the Context API in part 1 needs Enterprise / Business Critical)
- An AWS account you can deploy into, plus a CLI profile that reaches it
- GitHub: the Pulumi GitHub App installed, with access to your fork of the demo repo
- PagerDuty: a free 14-day trial — sign up as a dedicated bot user; mint an API token
- Linear: a free workspace with one open ticket (e.g. "Add versioning to the staging bucket")
  and a personal API key
```

Connect the integrations in the Pulumi console — **Settings → Neo → Integrations**:

```
MCP tools:   PagerDuty (your bot user's token), Linear (your API key)
CLI tools:   aws → an ESC environment scoped READ-ONLY
             (why read-only, and how to build one: docs/credentials.md and demo/esc-readonly-role/)
```

## Setup

Fork and clone the incident program — a fork, because Neo opens its fix PR
against this repo:

```bash
git clone https://github.com/adamgordonbell/neo-workshop-incident   # fork first, clone your fork
cd neo-workshop-incident
npm install
pulumi stack init adamgordonbell-org/dev
pulumi config set aws:region ca-central-1
pulumi config set --secret pagerduty:token   # paste your PagerDuty API token
pulumi config set pagerdutyEmail you@example.com   # where the page lands — a real inbox, not your PagerDuty signup address
```

Deploy it — the payment pipeline Neo will diagnose, plus the entire PagerDuty
side (team, rotation, escalation policy, service, CloudWatch integration):

```bash
pulumi up          # ~5 min; the RDS instance is the slow part
```

The program carries three deliberate faults — see the `FAULT` comments in
[`index.ts`](https://github.com/adamgordonbell/neo-workshop-incident/blob/main/index.ts).

Then, from this workshop repo, verify everything is wired:

```bash
cd extending-pulumi-neo/demo
./prewarm.sh       # 9 checks, all must be ok; it prints the UI-only ones to eyeball
```

## Part 1 — What does Neo know? The Context API

One read-only query against the resource graph. From this repo:

```bash
cd demo/context-api
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

About 90% of the account isn't managed by Pulumi — everything after this is
about reaching that other 90%. Two more queries, same shape:

```bash
pulumi api GraphQuery -F orgName=adamgordonbell-org --input unmanaged-by-type.json          # what kind of thing is unmanaged
pulumi api GraphQuery -F orgName=adamgordonbell-org --input unmanaged-security-groups.json  # found 3, all in ca-central-1
```

Full write-up + a curl form for older CLIs: [`demo/context-api/README.md`](demo/context-api/README.md).

## Part 2 — Ask: a Linear ticket becomes a PR

With the Linear MCP connected and a ticket waiting, hand Neo the ticket. From
your `neo-workshop-incident` clone:

```bash
cd neo-workshop-incident     # Pulumi.yaml + the git remote live here — Neo needs both
pulumi neo
```

> Pick up the open Linear ticket about the staging bucket, make the change in
> this program, and open a PR. Comment back on the ticket with the PR link.

Watch the task read the ticket over MCP, write the change, and open the PR —
Neo reads your tools, not your paste buffer.

## Part 3 — Delegate: a PagerDuty incident, end to end

Cause a real page. The script sends a poison payment message, then plays the
failing consumer (there is no worker in the stack — without its
receive-without-delete loop, nothing ever dead-letters):

```bash
cd extending-pulumi-neo/demo
./trigger-incident.sh        # incident opens ~3 min later — SQS ships CloudWatch metrics at ~1-min granularity
```

```
Poison payment sent to the payment queue.
Message dead-lettered after 2 receive attempt(s).      # ~13s in
```

When the page arrives (check your PagerDuty service and your inbox), hand the
incident to Neo:

```bash
cd neo-workshop-incident
pulumi neo
```

> We're getting paged. Check PagerDuty for the open incident, find out why
> payment messages are dead-lettering, and fix the cause in this program.
> Open a PR.

Neo reads the incident over the PagerDuty MCP, reads live queue state through
the `aws` CLI integration, and lands on FAULT 1 — `maxReceiveCount: 1`, no
retry, every transient failure dead-letters. The fix arrives as a PR on your
fork; the incident resolves back in PagerDuty.

Reset between runs:

```bash
cd extending-pulumi-neo/demo
./cleanup.sh                 # purge queues → alarm OK → incident auto-resolves; re-arm with ./trigger-incident.sh
```

## Part 4 — Scope: whose credentials is Neo holding?

The `aws` integration hands Neo whatever the ESC environment resolves — which
is why it should resolve a read-only role. Prove what it can and can't do:

```bash
pulumi env run adamgordonbell-org/<your-readonly-env> -- aws sts get-caller-identity   # the read-only role
pulumi env run adamgordonbell-org/<your-readonly-env> -- aws sqs purge-queue --queue-url <url>   # AccessDenied — the point
```

Building that environment: [`demo/esc-readonly-role/`](demo/esc-readonly-role/)
and [`docs/credentials.md`](docs/credentials.md).

## Part 5 — Stop initiating: scheduled tasks

In the console: **Neo → Scheduled Tasks → New**. Give it a task ("run the CIS
benchmark against this stack, open a PR for anything it finds") and a schedule.
Tomorrow morning the PR is just *there* — you set it once and stop initiating.

## Teardown

```bash
cd neo-workshop-incident
pulumi destroy       # removes the AWS chain and the PagerDuty config
pulumi stack rm dev
```

Your PagerDuty trial expires on its own; delete the Linear workspace if you
made one just for this.
