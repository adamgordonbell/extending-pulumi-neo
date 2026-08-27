# Demo budget

**60 minutes. Slide-driven, with two demos done live and the rest carried by video.**

The scarce resource is not slides and not content — it is **live demo minutes**, and their
real cost is paid on **Thu Aug 27**, not on stage. Each live demo has to be *stood up,
credentialed, rehearsed, and made re-runnable*. There is one prep block. So the question
for each candidate is not "would this be good?" but **"what does it cost to make this
exist, and what breaks if it fails live?"**

---

## The verdict

| Candidate | Post item | Mode | Live cost | If it dies |
|---|---|---|---|---|
| **Ticket → PR** | #4 Linear | 🔴 **LIVE** | Low | Play `neo-linear.mp4` |
| **Incident → PR** | #3 PagerDuty + `aws` | 🔴 **LIVE** | **High** | Nothing. Protect this one. |
| Integration toggle | #2 Honeycomb | 🎬 video | — | `honey-comb.mp4` (24s) |
| IAM narrowing | #5 | 🎬 video | Medium | `iam-narrow.mp4` (60s) |
| Scheduled ops | #8/9/10 | 🎬 video **only** | Impossible | `neo-cis-pr.mp4` (17s) + `neo-schedule-setup.mp4` (18s) |
| Deploy to AWS | #1 | ❌ cut | — | `deploy-to-aws2.mp4` (7.5s) held spare |
| Engin's Falco/Trivy/Kyverno cluster | — | 📊 **slides** | Prohibitive | n/a |

**Two live demos. ~27 of 60 minutes. Everything else is slides and 3.4 minutes of video.**

---

## Why each call

### 🔴 Linear — live. The cheap one.

Setup is a personal API key and a pre-filed ticket. No trial clock, no cloud account, no
ESC environment, no incident chain, nothing to provision. It is the **only** candidate
whose live cost is near zero, which is exactly why it opens: it earns "an integration is
just a toggle" before anything expensive is at stake.

It also happens to be the one already shot **in the Pulumi CLI** (`neo-linear.mp4`, 76s) —
the same surface the session is driven from. Backup and live version match.

### 🔴 PagerDuty incident — live, and the only thing worth the setup budget.

This is the session. It is also, by a distance, the most expensive thing to stand up:

- a PagerDuty trial, on a dedicated `pulumi-bot` user (MCP tokens are user-scoped)
- the trial term — **settled:** 14 days, so starting on Aug 27 puts Sep 8 on day 12. Do not start it earlier.
- Engin's July *Incident Response as Code* program deployed to seed team, rotation, escalation policy, service, CloudWatch integration
- an AWS account, and a **narrow** ESC environment (see `credentials.md`)
- region agreement across ESC env, program, and alarm
- GitHub connected so the PR actually opens
- a trigger that fires **on demand and more than once**, because it must survive rehearsal

⇒ **Spend the whole Thursday block here.** Every other demo is either cheap or a video.

### 📊 Engin's cluster — slides, not a rebuild.

His Dec 2025 workshop ran Falco, Trivy, Kyverno and Prometheus on a DigitalOcean
Kubernetes cluster, feeding PagerDuty through Falcosidekick/Alertmanager, then a webhook
service into the Neo API. Four detection tools, a cluster, and a deployed service.

**Do not rebuild that for Sep 8.** It cannot be stood up, rehearsed and made reliable in
one prep block, and it is not what this workshop is about — his four scenarios demonstrate
*detection*, while this session demonstrates *integrations*.

**Take instead the simpler trigger from his July blog:** SQS dead-letter queue →
CloudWatch alarm → SNS → PagerDuty. Pure AWS, no cluster, no agents, and it produces the
same thing the demo actually needs — a real page with a real timestamp, on demand.

His architecture still appears, **as a slide**: this is what it took in December, and here
is the part that is now a toggle. That is the honest merge of the two talks, and it costs
one diagram instead of a cluster.

### 🎬 Scheduled ops — video by definition.

A task that runs at 6 AM daily cannot be demonstrated at 12:45 PM. There is no live
version of items 8/9/10 at any setup cost. `neo-schedule-setup.mp4` shows the scheduling
UI and `neo-cis-pr.mp4` shows the resulting PR, which together are the whole story:
*you set it once, and then you stop initiating it.*

### 🎬 IAM narrowing — video, though it is the closest call.

Live would need genuinely over-privileged roles in a real account and a Neo run long
enough to cross-reference them. `~/sandbox/iam-narrow-demo` exists, so the live version is
*reachable* — but it lands in the scope beat, where the argument is carried by the PR body
and the role name, both of which read fine from a 60-second clip.

**Promote it to live only if the PagerDuty trial falls through** and beat 3 has to be
rebuilt around `aws` alone.

---

## Using the clips on stage

They are **silent autoplay blog loops**, not narrated walkthroughs. Consequences:

- **Talk over every one of them.** The clip is B-roll for what you are saying.
- **The short ones flash past.** 17s and 18s clips need pausing on the frame that matters — the PR body, the schedule form — or they register as motion rather than content.
- `iam-narrow.mp4` (60s) and `neo-linear.mp4` (76s) are long enough to narrate straight through.
- Total run time all six: **3.4 minutes.**

---

## Where the slides carry the weight

Everything not listed above is a slide, and that is the intended shape — the argument
should be complete before anything can break live:

- The two kinds of integration, and why the split matters
- The six-integration catalog — `neo-integration-catalog.png` does this in one image
- Credentials: who owns them, where they are decrypted, what Neo never sees
- Per-task toggles and named instances
- Engin's December architecture, and the inbound/outbound distinction
- The arc itself: ask → delegate → stop initiating
- Where it goes next: automations, editors, the handoff skill
