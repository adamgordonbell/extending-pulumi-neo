# Demo

The Pulumi program Neo diagnoses and fixes, plus the scripts that cause an incident on
demand.

**Not built yet** — scaffolded Aug 25, built at the Thu Aug 27 block.

## Planned

| Path | What |
|------|------|
| `pulumi-ts/` | The program Neo reads and opens a PR against |
| `trigger-incident.sh` | Cause a real PagerDuty page on demand |
| `cleanup.sh` | Resolve the incident, revert the program, reset state |
| `prewarm.sh` | Pre-flight checks — integrations connected, ESC env resolving, region agreement |

## The constraint that shapes all of it

A fresh PagerDuty account has **no history**. Any finding Neo reports has to be visible in
a single look at current state — never a trend.

Good (configuration-shaped, and each is a real bug):

- A queue with no redrive policy
- `maxReceiveCount` of 1
- `AllocatedStorage` equal to `MaxAllocatedStorage`
- An alarm wired to no action

Bad (trend-shaped, undemonstrable here): *"storage has grown 5 GB/day for 30 days."* This
is the launch blog's marquee example and it cannot be reproduced on a new account.

## Trigger mechanism

From Engin's [`pulumi-ai-workshop-base`](https://github.com/dirien/pulumi-ai-workshop-base)
and his [Incident Response as Code](https://www.pulumi.com/blog/incident-response-as-code-pagerduty-pulumi/)
post: an SQS dead-letter queue feeding a CloudWatch alarm feeding SNS feeding PagerDuty.
Push a message, watch a real incident open with a real timestamp.

His program also provisions the entire PagerDuty side — team, weekly rotation, two-level
escalation policy, service with CloudWatch integration — which means one `pulumi up` seeds
a fresh trial account.
