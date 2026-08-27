# What shipped since the integrations launch

Checked **Thu Aug 27 2026** against `#product-updates` in Pulumi Slack (75-day
sweep) and the live docs site. Every link below was fetched and returns 200.

## The headline: nothing new on integrations

**No ship touching MCP or CLI integrations has landed since the May 20 launch.**
The launch post is still the whole story, and the workshop is built on current
material rather than a moving target. That's the answer to "did I miss
something" — no.

Source of truth for the deck's integration content stays:

- [Neo integrations overview](https://www.pulumi.com/docs/ai/neo/integrations/)
- [CLI integrations](https://www.pulumi.com/docs/ai/neo/integrations/cli/) — `aws`, `gcloud`, `az`, `kubectl`
- [MCP integrations](https://www.pulumi.com/docs/ai/neo/integrations/mcp/) — Atlassian, Datadog, Honeycomb, Linear, PagerDuty, Supabase
- Launch post: `~/sandbox/docs/content/blog/neo-integrations/` — "Neo Integrations: MCP Servers and Cloud CLIs", May 20 2026

## Four Neo ships that touch the deck

### 1. Neo in your editor (ACP adapter) — Jul 30

Neo runs inside Zed, JetBrains IDEs, VS Code, and Cursor over the Agent Client
Protocol. In the editor it inherits the CLIs you're already authenticated to,
which is the same reach story the workshop tells, arrived at from the other end.

- Docs: <https://www.pulumi.com/docs/ai/neo/editors/>
- Announced: [#product-updates, Jul 30](https://pulumi.slack.com/archives/C0AVDRQF71V/p1785405452856749) (venelin)

**Why it matters here:** this is the leading candidate for **beat 5**. The event
page description already promises it by name — "Neo in your editor — Zed,
JetBrains, VS Code, or Cursor" — so it gets mentioned whether or not it becomes
the closing demo. Scheduled Automations is the alternative and is also promised
in the same paragraph. Shipped and documented, so either is safe to show.

### 2. Task creation permissions — Aug 10

Org admins can deny users in their org access to Neo entirely. Enterprise+.
An on/off switch plus per-feature toggles, at **Settings > Neo access**.

- Docs: <https://www.pulumi.com/docs/ai/neo/settings/#neo-access>
- Permission model, the fuller picture: <https://www.pulumi.com/docs/ai/neo/permissions/>
- Announced: [#product-updates, Aug 10](https://pulumi.slack.com/archives/C0AVDRQF71V/p1786353476967479) (venelin)

**Why it matters here:** the SCOPE section covers per-task integration toggles
and read-only credential scoping, but not *who is allowed to use Neo at all*.
That's a control surface an enterprise audience will ask about. Worth one line,
probably not a slide.

The permissions page also states the thing the deck leans on — Neo operates
within the acting user's RBAC entitlements and cannot do what that user
couldn't. Good citation if someone challenges the read-only claim.

### 3. Neo usage limits — Jul 14

Dollar spend limits on Neo, org-wide or per member, with email alerts as usage
approaches the cap. Settings > Billing & usage.

- Docs: <https://www.pulumi.com/docs/ai/neo/usage-limits/>
- Announced: [#product-updates, Jul 14](https://pulumi.slack.com/archives/C0AVDRQF71V/p1784070600515159) (jkeiser)

**Why it matters here:** same bucket as #2 — a control surface, not a reach
surface. Pairs naturally with it if you add a "what else you can turn down"
line. Skip if time is tight.

### 4. Context API — Aug 26 ⚠️ do not mention

A single queryable graph of everything Pulumi knows about an org. Query is a
JSON document: `anchor` names starting nodes, `traverse` walks relationships.

- Announced: [#product-updates, Aug 26](https://pulumi.slack.com/archives/C0AVDRQF71V/p1787784110139139) (Levi Blackstone)
- **Docs: none.** The announcement says "coming soon."

**Why it's excluded.** Thematically it's the closest thing to this workshop's
subject — what Neo can reach — and that makes it tempting. But it shipped the
day before this check, has no documentation, and in the announcement thread Josh
Kodroff asked "how soon is now?" about the docs while Joe Duffy called the query
syntax opaque and asked for a reference page with examples. Sending a workshop
audience to a page that doesn't exist is worse than not mentioning it. Re-check
before Sep 30 in case docs land for Engin's EMEA run.

## Custom Agents — ❓ still unannounced

**Status: question mark. Nothing has changed.** No `#product-updates` post in
120 days, no docs page, no mention anywhere on the docs site. The only "Custom
Agent" strings in the Neo docs are Zed's and JetBrains' own UI labels on the
editors page for adding an ACP agent — unrelated to the Pulumi feature.

The ⛔ in `PRESENTER.md` stands as written: **do not promise Custom Agents.**
Engin's Sep 23 AKS session is where that lives, and it lands *after* your Sep 8
but *before* his Sep 30 EMEA repeat — so this may be sayable on the second run
and not the first. Flag it to him rather than leaving the guard rail silently
wrong for his date.

Re-check before each delivery. If it gets announced between now and Sep 8, it
changes what the closing slide can promise.

## How to re-run this check

```bash
~/para/scripts/slack-activity search "Neo" --in product-updates --days 60
~/para/scripts/slack-activity search "integration" --in product-updates --days 60
~/para/scripts/slack-activity search "custom agent" --in product-updates --days 120
```

Then confirm anything promising actually has a docs page before it goes in the
deck — the Context API is the cautionary case.
