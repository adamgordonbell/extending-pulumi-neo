# Presenter run-of-show — Extending Pulumi Neo: MCP Servers and Cloud CLIs

> **60 minutes, demo-only, driven from `pulumi neo` in the terminal.** Attendees watch
> and clone this repo afterward. Decide the cuts **before** you walk on, not at minute 45.
>
> The [published listing](https://www.pulumi.com/events/extending-pulumi-neo-mcp-cloud-cli/)
> is the promise; beat 2 is that promise, live.

## Pre-flight

**Auth is always manual — do it now, not on stage.**

```bash
pulumi login && pulumi whoami -v        # expect org: adamgordonbell-org
pulumi env ls -o adamgordonbell-org     # the workshop ESC env is listed
```

Lights, all of which must be green:

- [ ] `pulumi neo` starts from the demo project directory (needs a `Pulumi.yaml`)
- [ ] PagerDuty integration connected at the org level, and its trial has **not** expired
- [ ] `aws` CLI integration connected, pointed at the **narrow** ESC environment (not `shared/cloud-creds` — see `docs/credentials.md`)
- [ ] Linear integration connected, with a ticket already filed and waiting
- [ ] `pulumi env run <ref> -- aws sts get-caller-identity` returns the expected role
- [ ] The incident trigger works — `demo/prewarm.sh` passes, and you have caused a page at least once today
- [ ] The PagerDuty **trial has not expired** — 14-day term, so it must have been started on or after **Aug 27** to reach Sep 8 (which lands on day 12 of 14)
- [ ] GitHub connected, so Neo can actually open the PR
- [ ] Region agreement: ESC env, the Pulumi program, and the alarm all in the same region

**Terminal hygiene — this demo puts your shell on screen.** Fresh window, cleared
scrollback, no unrelated env vars, no other orgs in view, font size up.

## Beats

| # | Beat | Target | Slide |
|---|------|--------|-------|
| 1 | Why — Neo could always write Pulumi | 12:02–12:07 | |
| 2 | **Ask** — a ticket becomes a PR (Linear) | 12:07–12:14 | |
| 3 | **Delegate** — the incident (PagerDuty + `aws`) | 12:14–12:34 | ⏱ trigger it during beat 2 |
| 4 | **Scope** — what Neo can reach, and who decided | 12:34–12:44 | |
| 5 | **Stop initiating** — it runs without you | 12:44–12:52 | |
| 6 | Q&A | 12:52–1:00 | |

Full beat content lives in [`OUTLINE.md`](OUTLINE.md). This file is the clock and the
failure plan.

## ⏱ The one timing trap

**Run `demo/trigger-incident.sh` during beat 2, not at the top of beat 3.**

The page is not instant. Even with `maxReceiveCount: 1` and a 5-second visibility
timeout, the CloudWatch alarm evaluates on a 60-second period, so budget **1–2 minutes**
from running the script to the incident opening. Engin's original chain, at
`maxReceiveCount: 3`, took **3m45s** — longer than the entire Linear beat.

So: start the Linear demo, run the trigger in a second pane while Neo is working, and by
the time you reach beat 3 the incident is already open and waiting. Standing in silence
watching an alarm is the most avoidable dead air in the session.

## Cuts, decided in advance

1. **Beat 5 goes first.** One slide plus `neo-cis-pr.mp4`; narrate it and move on.
2. **Beat 2 degrades to the clip.** Play `neo-linear.mp4` instead of driving it live.
3. **Beat 3 never gets cut.** If beat 3 cannot run, the session has no content.

## When it breaks

- **An integration is missing from the composer.** Neo reads connected integrations at task start; if one was disconnected or its ESC environment deleted, Neo skips it and continues. Say so and keep going — it is a real behaviour worth showing, not an outage.
- **Neo says it can't run the CLI.** Usually the ESC environment is missing a variable, or the credentials are not authorized for what Neo tried. Reproduce with `pulumi env run <ref> -- <cli> <args>`. Do not debug live past one attempt.
- **The page never fires.** Fall back to an incident you triggered before the session and left open.
- **Everything is down.** ⭐ **Every beat has a recording** — the six videos from the *Ten More Things* post are in `slides/public/`. Switch that beat to its clip; the show does not change. This is the fallback R2 never had.

## Things not to say

- ⛔ Do not say the PagerDuty MCP integration replaces Engin's webhook. It covers the reading half only; auto-*starting* a task from an incident still needs his glue.
- ⛔ Do not claim credentials are scoped read-only unless the ESC environment in use actually is.
- ⛔ **Do not name Custom Agents.** Unannounced as of Aug 27 — no `#product-updates` post
  in 120 days, no docs page. Two reasons now, not one: it isn't public, *and* what we know
  about its status is internal pre-release, so even a hint sourced from that is a leak.
  This holds for **Sep 8** regardless of how close it looks.
- ✅ **You may point at the Sep 30 EMEA session and say it goes further** — Sep 8 as part
  one, Engin's repeat as part two. That framing is safe as long as you name no feature.
  Naming one from stage, on the closing slide, or in event copy needs sign-off first.
