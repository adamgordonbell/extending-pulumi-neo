# Outline — Extending Pulumi Neo: MCP Servers and Cloud CLIs

**Tue Sep 8 2026 · 12:00–1:00 PM ET · 60 minutes · BigMarker `f4d6709a7b01`**
Adam Gordon Bell presents. EU repeat Wed Sep 30, Engin Diri.

> **Shape: demo-only.** Adam drives; attendees watch and clone the repo afterward.
> There is no follow-along block — 60 minutes has no room for one, and MCP integrations
> are an org-admin toggle attendees cannot perform on their own org mid-session.
> ⛔ Do not reintroduce a `chapters/` directory.

**Delivery surface:** `pulumi neo` in the terminal. Integrations carry over from Pulumi
Cloud, so ESC-backed CLI integrations work the same way from the CLI.

---

## The argument

Neo could always write Pulumi. What it could not do was *look at the systems the incident
actually lives in*. Integrations close that gap in two different ways, and the difference
is the spine of the session:

- **MCP integrations** — Neo reads your SaaS: PagerDuty, Linear, Datadog, Honeycomb, Atlassian, Supabase. Credentials encrypted per-org, decrypted at task time, never shown to the model.
- **CLI integrations** — Neo runs `aws`, `gcloud`, `az`, `kubectl` against credentials **you** scope in Pulumi ESC. Pulumi Cloud never stores them.

Ending state of every demo is the same and it matters: **a reviewable pull request.**
Neo proposes; a human merges.

---

## Run of show (60 min)

| # | Beat | Time | Purpose |
|---|------|------|---------|
| 1 | **Opener — ticket to infra change** (Linear) | ~7 | Cheapest possible proof. 30 seconds of setup, one integration, ends in a PR. |
| 2 | **The incident walkthrough** (PagerDuty + `aws`) | ~22 | The spine. Real page, real diagnosis, real PR, resolved back to PagerDuty. |
| 3 | **Scope and blast radius** | ~10 | What Neo can reach, and who decided. Per-task toggles, ESC scoping, the credential story. |
| 4 | **Beyond the interactive task** | ~8 | One of: per-automation CLI integrations, or Neo in the editor via ACP. Pick one. |
| 5 | **Q&A** | ~10 | |

**Cut order if running long:** beat 4 first, then trim beat 1 to a screenshot. **Beat 2 never gets cut** — it is the session.

---

## Beat detail

### 1 — Opener: ticket to infra change

Linear MCP integration, personal API key, minutes to set up. Ask Neo to pick up a ticket
describing an infra change; it reads the ticket, edits the program, opens a PR.

Point being made: *an integration is a toggle, and the output is reviewable.*

### 2 — The incident walkthrough

Prior art to credit and build on: **Engin Diri's "Day-2 Autonomous Infrastructure
Management," Dec 9 2025** — recording <https://www.youtube.com/watch?v=nx6oJvX2JNE>,
repo <https://github.com/dirien/pulumi-ai-workshop-base>. Adam co-presented.

1. **Cause a real page.** Not a fixture — a live incident with a real timestamp.
2. **Neo reads the incident** through the PagerDuty MCP integration.
3. **Neo inspects live infrastructure** through the `aws` CLI integration, ESC-backed.
4. **Neo edits the Pulumi program** and previews the change.
5. **PR opened. Human reviews.** Resolve back to PagerDuty.

🔑 **The finding must be configuration-shaped, not trend-shaped.** A fresh account has no
history, so "storage grew 5 GB/day for 30 days" — the launch blog's marquee beat — cannot
be demonstrated. Use findings visible in a single look: a queue with no redrive policy,
`maxReceiveCount` of 1, `AllocatedStorage == MaxAllocatedStorage`, an alarm wired to no
action.

⛔ **Do not claim the MCP integration replaces Engin's webhook.** His glue was the
**inbound** leg — PagerDuty `incident.trigger` → Neo API *creates* a task. The MCP
integration is the **outbound** leg — Neo *reading* PagerDuty during a task already
running. Honest framing: *"the reading half is now a toggle; the triggering half is still
yours to wire."*

### 3 — Scope and blast radius

The question the room is actually holding: *what can this thing reach?*

- Integrations are enabled by an org admin, and any single task can toggle them **off** from the composer without touching org config.
- MCP credentials: encrypted at rest per-org, decrypted at task time, never exposed to the model, never in task state.
- CLI credentials: owned by ESC, not Pulumi Cloud. Neo runs `pulumi env run <ref> -- <cli> <args>` **as the acting user** — an integration works only for someone who could open that environment themselves. Connecting one grants nobody access they did not already have.
- Named instances — `production-aws` vs `staging-aws` — each with its own ESC environment and a Notes field Neo reads when choosing.
- **Neo never needed write access to do beat 2.** The remediation was a pull request. Say this out loud.

### 4 — Beyond the interactive task

Pick **one**:

- **Per-automation CLI integration selection** — CLI integrations inside scheduled Automations, not just interactive tasks. (Merged 2026-08-06; confirm the surface before demoing.)
- **Neo in your editor via ACP** — Zed, JetBrains, VS Code, Cursor.

Optional callback if time allows: the [Neo handoff skill](https://github.com/pulumi/agent-skills/tree/main/delegation) lets Claude Code start a `pulumi neo` task — ties back to the Aug 12 *DevOps AI Skills* workshop.

---

## Open before build (Thu Aug 27, 1:00–2:30)

- [ ] Watch the Dec 9 recording (`nx6oJvX2JNE`) — closest prior art, Adam is in it
- [ ] Stand up the PagerDuty trial (dedicated `pulumi-bot` user; MCP tokens are user-scoped) and confirm the trial term against Sep 8
- [ ] Seed it with Engin's July "Incident Response as Code" program
- [ ] Narrow ESC environment for the `aws` integration — see `docs/credentials.md`
- [ ] Resolve credential precedence for `pulumi neo` — see `docs/credentials.md`
- [ ] Decide beat 4: automations or editor
- [ ] Confirm the live event page and Luma copy no longer say 90 minutes

Planning record: `~/para/projects/neo-mcp-workshop/PLAN.md`
