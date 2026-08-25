# Proposed run sheet — 27 slides, 60 minutes

**Tue Sep 8 2026 · 12:00–1:00 PM ET.** Slide-driven, two live demos, 3.4 min of video.
Why each demo is live/video/cut: [`docs/demo-budget.md`](docs/demo-budget.md).
Content and claims: [`OUTLINE.md`](OUTLINE.md). Failure plan: [`PRESENTER.md`](PRESENTER.md).

| # | Slide | Clock | Notes |
|---|-------|-------|-------|
| | **OPEN** | **12:00** | |
| 1 | Cover — Extending Pulumi Neo | | |
| 2 | Adam Gordon Bell | | |
| 3 | Housekeeping — present + demo, ask anytime, EMEA repeat Sep 30 | | |
| 4 | The arc: **ask → delegate → stop initiating** | | Agenda, but it's also the argument |
| | **WHY** — the gap | **12:04** | |
| 5 | Neo could always write Pulumi | | It couldn't see the systems the incident lives in |
| 6 | Two kinds of integration — MCP reads, CLI runs | | The one structural slide |
| 7 | The catalog | | `neo-integration-catalog.png` |
| 8 | 🎬 It's a toggle | | `honey-comb.mp4` · 24s · talk over it |
| 9 | **Every demo today ends in a reviewable PR** | | Load-bearing. Called back twice. |
| | **ASK** — a ticket becomes a PR | **12:09** | |
| 10 | The work that never reaches the top of the queue | | Item 4's framing: not unimportant, just never urgent |
| 11 | 🔴 **LIVE — Linear → PR** | | ~5 min. Fallback: `neo-linear.mp4` (76s) |
| 12 | What just happened | | One integration. Thirty seconds of setup. A PR. |
| | **DELEGATE** — the incident | **12:17** | |
| 13 | On-call triage is the first twenty minutes | | Getting up to speed, not fixing |
| 14 | December: what this took | | Engin's architecture — detection → PagerDuty → webhook → Neo API |
| 15 | The reading half is now a toggle | | ⛔ inbound vs outbound. Do not overclaim. |
| 16 | 🔴 **LIVE — page → read → inspect → PR → resolve** | | ~15 min. **Never cut.** |
| 17 | What just happened | | Name the finding; it's configuration-shaped, and that's on purpose |
| | **SCOPE** — what it can reach | **12:39** | |
| 18 | The question you're actually holding | | |
| 19 | Two credential models, side by side | | MCP: encrypted per-org, never seen by the model · CLI: ESC-owned, run as you |
| 20 | `pulumi env run … aws-readonly` | | **Neo never needed write access.** Callback to slide 9. |
| 21 | 🎬 Least privilege, by the thing you thought had too much | | `iam-narrow.mp4` · 60s · narrate straight through |
| 22 | Per-task toggles · named instances | | Org enables; any task can switch off |
| | **STOP INITIATING** | **12:48** | |
| 23 | You delegate it, then you stop initiating it | | The payoff line, and it's the post's |
| 24 | 🎬 Set it once | | `neo-schedule-setup.mp4` (18s) → `neo-cis-pr.mp4` (17s) · **pause on the PR body** |
| 25 | The runbook decides | | `neo-drift-pr.png` — accept, revert, or ignore |
| | **CLOSE** | **12:53** | |
| 26 | Where this goes next | | Automations · editors · the handoff skill |
| 27 | Thanks — QR, docs, EMEA Sep 30 | | |
| | **Q&A** | **12:55–1:00** | |

## Shape

- **27 slides · 20 min live demo · 3.4 min video · ~26 min talking · 5 min Q&A**
- Two live demos, both in beats that can degrade to a clip. **Beat 16 is the exception — it has no substitute.**
- Three video moments, all under a minute, all narrated.
- The argument is complete by slide 9. Everything after it is evidence.

## Cuts, in order

1. **Slides 23–25** (stop initiating) — one line and two clips; narrate slide 23 and skip the rest
2. **Slide 21** (`iam-narrow.mp4`) — the scope argument survives on slides 19–20
3. **Slide 11 goes to video** — play `neo-linear.mp4` instead of driving it
4. **Slide 16 never gets cut**

## What each section owes the room

| Section | The one thing they leave with |
|---|---|
| Why | Neo's limit was context, not capability |
| Ask | An integration is a toggle, and the output is reviewable |
| Delegate | A real page becomes a real PR, without a human reading three consoles |
| Scope | Nobody got access they didn't have, and Neo never needed write |
| Stop initiating | The end state isn't asking faster — it's not asking |
