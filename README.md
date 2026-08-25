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

Neo could always write Pulumi. What it could not do was look at the systems around the
code. Integrations close that gap two ways:

- **MCP integrations** — Neo reads PagerDuty, Linear, Datadog, Honeycomb, Atlassian, Supabase. Credentials are encrypted per-organization, decrypted at task time, and never exposed to the model.
- **CLI integrations** — Neo runs `aws`, `gcloud`, `az`, and `kubectl` against credentials you scope yourself in Pulumi ESC. Pulumi Cloud never stores them.

Every demo ends the same way, and that is the point: **a reviewable pull request.** Neo
proposes; a human merges.

By the end you will have seen:

- An incident go from a real PagerDuty page to a merged fix, without a human reading a console
- How Neo's access is scoped, per organization and per task
- What credentials Neo uses, who owns them, and what it cannot reach
- Where integrations go next — scheduled automations and Neo in your editor

## Who it's for

Platform engineers, SREs, and infrastructure teams already running Pulumi who want an
agent that can see production, not just the program.

## Repo layout

| Path | What |
|------|------|
| [`OUTLINE.md`](OUTLINE.md) | The argument and the beat-by-beat content |
| [`PRESENTER.md`](PRESENTER.md) | Run-of-show, pre-flight checklist, cuts, failure plan |
| [`docs/credentials.md`](docs/credentials.md) | Demo-org credential setup and open questions |
| `slides/` | Slidev deck (`@pulumi/slidev-theme`) |
| `demo/` | The Pulumi program and incident-trigger scripts |

## Running the deck

```bash
cd slides
npm install          # no token needed; @pulumi/slidev-theme is on public npm
npm run dev          # http://localhost:3030
npm run build        # static site into dist/
```

## Prior art

The incident walkthrough builds directly on **Engin Diri's "Day-2 Autonomous
Infrastructure Management"** (Dec 9 2025), which Adam co-presented:

- Recording: https://www.youtube.com/watch?v=nx6oJvX2JNE
- Repo: https://github.com/dirien/pulumi-ai-workshop-base
- Follow-up post: https://www.pulumi.com/blog/incident-response-as-code-pagerduty-pulumi/

One distinction that workshop makes clear and this one keeps: Engin's webhook service was
the **inbound** leg — PagerDuty fires, and a task gets created. The MCP integration is the
**outbound** leg — Neo reads PagerDuty during a task already underway. The reading half is
now a toggle; the triggering half is still yours to wire.

## Reference

- [Neo integrations](https://www.pulumi.com/docs/ai/neo/integrations/) · [MCP](https://www.pulumi.com/docs/ai/neo/integrations/mcp/) · [Cloud CLIs](https://www.pulumi.com/docs/ai/neo/integrations/cli/)
- [Neo in the Pulumi CLI](https://www.pulumi.com/docs/ai/neo/pulumi-cli/) · [Neo in your editor](https://www.pulumi.com/docs/ai/neo/editors/)
- [Launch post: Neo Integrations](https://www.pulumi.com/blog/neo-integrations/)
