# Extending Pulumi Neo: MCP Servers and Cloud CLIs

> A live workshop on giving [Pulumi Neo](https://www.pulumi.com/product/neo/) access to the
> systems your incidents actually live in — SaaS tools over **MCP**, and cloud accounts over
> **CLI integrations** backed by [Pulumi ESC](https://www.pulumi.com/docs/esc/).

**Presenter:** Adam Gordon Bell (Community Engineer), Pulumi
**Format:** Workshop · 60 min · demo-driven
**Sessions:** Americas — Tue Sep 8 2026, 12:00 PM ET · EMEA — Wed Sep 30 2026, Engin Diri
**Register:** https://www.pulumi.com/events/extending-pulumi-neo-mcp-cloud-cli/

---

## What it covers

**Neo already knew your infrastructure. Now it can reach past it. And it runs in
places you aren't.**

The session answers three questions in order:

**1 · What does it know?** Your code, your stacks, your state — and, since the
[Context API](https://www.pulumi.com/blog/pulumi-context-api/), all of that as one
queryable graph that includes the resources *no Pulumi program describes*. On the
demo org that's about 90% of the account.

**2 · What can it reach?** ← *this is what the session is titled after*
- **Out**, to the systems you operate with: **MCP integrations** (PagerDuty, Linear,
  Datadog, Honeycomb, Atlassian, Supabase) and **CLI integrations** (`aws`, `gcloud`,
  `az`, `kubectl`) against credentials you scope yourself in Pulumi ESC.
- **In**, from where you already work: **GitHub and Slack** — mention Neo in a PR
  thread or a channel and a task starts.

**3 · Where does it run?** Pulumi Cloud, your terminal, your editor over the Agent
Client Protocol (Zed, JetBrains, VS Code, Cursor) — and on a schedule, with nobody
there at all.

Every demo ends the same way, and that is the point: **a reviewable pull request.**
Neo proposes; a human merges.

By the end you will have seen:

- A Linear ticket become a pull request, live
- A real PagerDuty page become a merged fix, live — including a finding that exists
  in the cloud account and in no Pulumi program
- How Neo's access is scoped, per organization and per task, and who holds which key
- The same agent running in four different places, ending with one nobody started

## Who it's for

Platform engineers, SREs, and infrastructure teams already running Pulumi who want an
agent that can see production, not just the program.

## Repo layout

One file owns each question. If two files answer the same one, one of them is wrong.

| Path | Owns |
|------|------|
| [`OUTLINE.md`](OUTLINE.md) | The argument — beats, claims, what each one owes the room |
| [`PRESENTER.md`](PRESENTER.md) | The clock and the failure plan — pre-flight, cuts, what to say |
| [`TODO.md`](TODO.md) | Everything still open. The maintained list. |
| [`docs/demo-budget.md`](docs/demo-budget.md) | Why each demo is live, video, or cut |
| [`docs/credentials.md`](docs/credentials.md) | Credential reasoning and the precedence question |
| [`docs/since-launch.md`](docs/since-launch.md) | What shipped after the launch, and what to avoid saying |
| [`docs/PLAN.md`](docs/PLAN.md) | Historical planning record — superseded, kept for provenance |
| `slides/` | Slidev deck (`@pulumi/slidev-theme`) |
| `demo/` | The Pulumi program, incident trigger, and the Context API queries |

## Running the deck

```bash
cd slides
npm install          # no token needed; @pulumi/slidev-theme is on public npm
npm run dev          # http://localhost:3030
npm run build        # static site into dist/
```

## Prior art

The incident walkthrough builds directly on **Engin Diri's "Day-2 Autonomous
Infrastructure Management"** (Dec 9 2025), which Adam co-presented — the fourth
and last part of Pulumi's monthly infrastructure-agents workshop series:

| # | Workshop | Date | Recording |
|---|---|---|---|
| 1 | Getting Started with Infrastructure Agents | 2025-10-14 | [_6abaK-dCz0](https://www.youtube.com/watch?v=_6abaK-dCz0) |
| 2 | Must-Have Enterprise Guardrails for Agent-driven Operations | 2025-10-23 | [-P3aBpE0CYE](https://www.youtube.com/watch?v=-P3aBpE0CYE) |
| 3 | Self-Service Platforms for Agent-Driven Developer Productivity | 2025-11-06 | [gK1N88I0GQ8](https://www.youtube.com/watch?v=gK1N88I0GQ8) |
| 4 | **Day-2 Autonomous Infrastructure Management** | 2025-12-09 | [nx6oJvX2JNE](https://www.youtube.com/watch?v=nx6oJvX2JNE) |

All four verified against `youtube_url` in the pulumi/docs event pages. There is
**no official playlist** bundling them, and no confirmed fifth part — the nearest
candidate, "AI Agents That Reason Over Your Infrastructure" (2026-01-14), is an
external co-hosted event with no recording URL and no presenters listed, so
whether it belongs to the series is unverified.

Day-2 detail:

- Recording: https://www.youtube.com/watch?v=nx6oJvX2JNE
- Repo: https://github.com/dirien/pulumi-ai-workshop-base
- Follow-up post: https://www.pulumi.com/blog/incident-response-as-code-pagerduty-pulumi/

One distinction that workshop makes clear and this one keeps: Engin's webhook service was
the **inbound** leg — PagerDuty fires, and a task gets created. The MCP integration is the
**outbound** leg — Neo reads PagerDuty during a task already underway. The reading half is
now a toggle; the triggering half is still yours to wire.

## Further reading

The eight posts on the closing "More reading" slide. All verified live Aug 27 2026.

**The story this session tells**

- [Neo Integrations: MCP Servers and Cloud CLIs](https://www.pulumi.com/blog/neo-integrations/) — May 20 2026. The launch post this session is built on; it shares the session's title.
- [Ten More Things You Can Do With Pulumi Neo](https://www.pulumi.com/blog/10-more-things-you-can-do-with-neo/) — May 19 2026. Where today's arc comes from.
- [10 Things You Can Do With Our Infrastructure Agent](https://www.pulumi.com/blog/10-things-you-can-do-with-neo/) — Oct 6 2025. The first one.
- [Neo, Now in the Terminal](https://www.pulumi.com/blog/pulumi-neo-cli/) — May 20 2026. The surface every demo is driven from.

**What the session goes deeper on**

- [Pulumi Context API: One Graph for All Your Infrastructure](https://www.pulumi.com/blog/pulumi-context-api/) — Aug 26 2026. The graph behind the coverage numbers.
- [Neo Automations: Scheduled Tasks Shipped as Pull Requests](https://www.pulumi.com/blog/neo-automations/) — May 21 2026. The `unattended` section.
- [Incident Response as Code: Managing PagerDuty with Pulumi](https://www.pulumi.com/blog/incident-response-as-code-pagerduty-pulumi/) — Jul 20 2026. Engin's program, used to seed the demo account.
- [Bringing Neo to GitHub and Slack](https://www.pulumi.com/blog/neo-github-slack/) — May 21 2026. The inbound half — starting a task from a PR thread or a channel.

## Reference

- [Neo integrations](https://www.pulumi.com/docs/ai/neo/integrations/) · [MCP](https://www.pulumi.com/docs/ai/neo/integrations/mcp/) · [Cloud CLIs](https://www.pulumi.com/docs/ai/neo/integrations/cli/)
- [Neo in the Pulumi CLI](https://www.pulumi.com/docs/ai/neo/pulumi-cli/) · [Neo in your editor](https://www.pulumi.com/docs/ai/neo/editors/)
- [Launch post: Neo Integrations](https://www.pulumi.com/blog/neo-integrations/)
