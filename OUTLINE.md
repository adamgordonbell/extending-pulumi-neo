# Outline — Extending Pulumi Neo: MCP Servers and Cloud CLIs

**Tue Sep 8 2026 · 12:00–1:00 PM ET · 60 minutes · BigMarker `f4d6709a7b01`**
Adam Gordon Bell presents. EU repeat Wed Sep 30, Engin Diri.

> **Shape: demo-only.** Adam drives from `pulumi neo` in the terminal; attendees watch and
> clone the repo afterward. No follow-along block — 60 minutes has no room, and MCP
> integrations are an org-admin toggle attendees cannot perform on their own org
> mid-session. ⛔ Do not reintroduce a `chapters/` directory.

---

## The concept: "Ten More Things," live

The session is the **`neo-things` series done on stage** — Adam's May 2026 post
[*Ten More Things You Can Do With Pulumi Neo*](https://www.pulumi.com/blog/10-more-things-you-can-do-with-neo/)
(`content/blog/10-more-things-you-can-do-with-neo/`), narrowed to the items that turn on
an integration, and performed instead of described.

**The post's own arc is the session's arc:**

> Items 1–7 are things you *ask for*. Items 8–10 run *without you*.
> *"Platform engineers used to keep things in their heads, then they delegated them to Neo,
> then those tasks started running on a schedule without anyone initiating them."*

That progression — **ask → delegate → stop initiating** — is the spine. Integrations are
what makes each step possible, which is why this workshop is the one that earns the arc.

### Which of the ten, and why

| # | Item | Integration | In session? |
|---|------|-------------|-------------|
| 4 | Implement a Linear/Jira ticket end-to-end | Linear MCP | ✅ **opener** — video already shot in the CLI |
| 3 | PagerDuty incident response | PagerDuty MCP | ✅ **the spine** |
| 5 | Audit over-privileged IAM roles | `aws` CLI + ESC | ✅ **the scope beat** |
| 8/9/10 | Drift · Lambda upgrades · CIS Benchmark | automations + `aws` | ✅ **the closer** — pick one |
| 2 | Diagnose a slow API from metrics | Datadog / Honeycomb MCP | 🟡 only if Honeycomb lands; no Datadog account |
| 1, 6, 7 | Deploy to AWS · CDK migration · containerize | — | ❌ not integration-driven; cut |

⚠️ **Accuracy notes.** Item 3 is written as **Slack**-invoked; this session drives from the
CLI, so re-frame rather than quote. Item 2 depends on Datadog, which we have no account
for — Honeycomb is the cheaper substitute but shows traces, not metrics.

---

## 🎬 The assets already exist

Six videos and four screenshots, shot by Adam in May, live in
`~/sandbox/docs/content/blog/10-more-things-you-can-do-with-neo/`:

| File | Shows | Use |
|------|-------|-----|
| `neo-linear.mp4` | **Neo in the Pulumi CLI**, Linear issue → PR | Opener — and it's already the right surface |
| `honey-comb.mp4` | Toggling an integration on | The "it's just a toggle" beat |
| `iam-narrow.mp4` | IAM audit → scoped policy, with evidence | Scope beat |
| `neo-schedule-setup.mp4` | Scheduled Tasks UI | Closer |
| `neo-cis-pr.mp4` | Morning CIS Benchmark PR | Closer |
| `deploy-to-aws2.mp4` | Repo → plan mode → PR | Spare |
| `neo-integration-catalog.png` | The six integrations, Authorize buttons | Anchor slide |
| `neo-drift-pr.png` · `neo-migration-prs.png` | PR bodies citing the runbook | Scope beat |

⭐ **This closes the fallback gap that was live risk on the Aug 12 workshop** — `PRESENTER.md`
wanted a recording per beat, none existed, and R2 ran without them. Here every beat has one
already, in Adam's own voice, on assets he owns.

**Backing repos, both local:** `~/sandbox/iam-narrow-demo` (item 5) ·
`~/sandbox/neo-examples` (EKS, `ca-central-1`, ESC `oidc/oidc`, policy pack, and a
`docs/script.md` that is probably the shooting script for the videos).

---

## Run of show (60 min)

| # | Beat | Time | The claim |
|---|------|------|-----------|
| 0 | **What** — Neo, and what day two means | ~3 | The work this is for is the work after the first deploy |
| 1 | **Why** — Neo could always write Pulumi | ~5 | It couldn't see the systems the incident lives in |
| 2 | **Ask** — a ticket becomes a PR (Linear) | ~7 | An integration is a toggle; the output is reviewable |
| 3 | **Delegate** — the incident (PagerDuty + `aws`) | ~20 | Page → diagnosis → PR → resolved, live |
| 4 | **Scope** — what Neo can reach, and who decided | ~10 | It never needed write access |
| 5 | **Stop initiating** — it runs without you | ~8 | Drift / CIS / upgrades on a schedule |
| 6 | **Q&A** | ~10 | |

**What each beat owes the room:**

| Beat | The one thing they leave with |
|---|---|
| What | Neo reads your live infrastructure and hands work back as a PR — and day two is the job |
| Why | Neo's limit was context, not capability |
| Ask | An integration is a toggle, and the output is reviewable |
| Delegate | A real page becomes a real PR, without a human reading three consoles |
| Scope | Nobody got access they didn't have, and Neo never needed write |
| Stop initiating | The end state isn't asking faster — it's not asking |

**Cut order lives in [`PRESENTER.md`](PRESENTER.md)** — that file owns the clock and the
failure plan, and its cuts are named by beat, so they survive slide renumbering.

---

## Beat detail

### 2 — Ask: a ticket becomes a PR

Item 4 of the post. Linear MCP integration, personal API key, about thirty seconds of
setup. Ask Neo to pick up a ticket; it reads title, description and acceptance criteria,
plans against the stack, opens a PR, and comments back on the ticket.

*An integration is a toggle, and the output is reviewable.*

### 3 — Delegate: the incident walkthrough

Item 3 of the post, and the through-line of Engin Diri's **"Day-2 Autonomous
Infrastructure Management"** (Dec 9 2025 — recording
<https://www.youtube.com/watch?v=nx6oJvX2JNE>, repo
<https://github.com/dirien/pulumi-ai-workshop-base>). Adam co-presented.

1. **Cause a real page** — not a fixture; a live incident with a real timestamp
2. **Neo reads the incident** — PagerDuty MCP
3. **Neo inspects what's actually running** — `aws` CLI, ESC-backed
4. **Neo edits the program** and previews
5. **PR opened. Human reviews.** Resolve back to PagerDuty

🔑 **The finding must be configuration-shaped, not trend-shaped.** A fresh account has no
history, so the launch blog's *"5 GB/day over 30 days"* cannot be demonstrated — and
neither can the post's own *"last 7 days of metrics"* framing in item 2. Use findings
visible in a single look: a queue with no redrive policy, `maxReceiveCount` of 1,
`AllocatedStorage == MaxAllocatedStorage`, an alarm wired to no action.

⛔ **Do not claim the MCP integration replaces Engin's webhook.** His glue was the
**inbound** leg — PagerDuty `incident.trigger` → Neo API *creates* a task. The MCP
integration is the **outbound** leg — Neo *reading* PagerDuty during a task already
running. Honest framing: *"the reading half is now a toggle; the triggering half is still
yours to wire."*

### 4 — Scope: what Neo can reach

The question the room is actually holding. Item 5 (IAM narrowing) is the natural vehicle —
it's a demo *about* least privilege, delivered by a tool people are worried has too much.

- An org admin enables an integration; any single task can toggle it **off** from the composer, without touching org config
- **MCP credentials** — encrypted at rest per-org, decrypted at task time, never exposed to the model, never in task state
- **CLI credentials** — owned by ESC, not Pulumi Cloud. Neo runs `pulumi env run <ref> -- <cli> <args>` **as the acting user**; an integration works only for someone who could open that environment themselves. Connecting one grants nobody access they didn't already have
- Named instances — `production-aws` vs `staging-aws` — each with its own environment and a Notes field Neo reads when choosing
- **Neo never needed write access to do beat 3.** The remediation was a pull request. Say this out loud.

### 5 — Stop initiating

Items 8, 9, 10 — drift detection, Lambda runtime upgrades, CIS Benchmark fixes. **Pick
one**; `neo-cis-pr.mp4` and `neo-schedule-setup.mp4` cover it. Per-automation CLI
integration selection is what makes these work with cloud access (merged 2026-08-06 —
confirm the surface before demoing).

The payoff line is the post's: *you delegate a task, and then you stop initiating it.*

Optional callback if time allows: the
[Neo handoff skill](https://github.com/pulumi/agent-skills/tree/main/delegation) lets
Claude Code start a `pulumi neo` task — ties back to the Aug 12 *DevOps AI Skills*
workshop.

---

## Before the build

Everything still open — yours, mine, and the Thursday block — lives in one place:
[`TODO.md`](TODO.md). It is the maintained list; this file is the argument.

Historical planning record (superseded, kept for provenance): [`docs/PLAN.md`](docs/PLAN.md)
