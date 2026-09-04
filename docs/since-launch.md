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

### 4. Context API — Aug 26 ✅ documented, and relevant

One queryable graph spanning IaC state, stack dependencies, and the resources
Discovery finds in cloud accounts **outside IaC entirely**. Public preview,
Enterprise and Business Critical editions.

- Blog: <https://www.pulumi.com/blog/pulumi-context-api/> (Levi Blackstone, Aug 26)
- Changelog: <https://www.pulumi.com/releases/changelog/> — "Query Your Infrastructure with the Pulumi Context API"
- Announced: [#product-updates, Aug 26](https://pulumi.slack.com/archives/C0AVDRQF71V/p1787784110139139)
- Live agent primer (the full query-language reference), fetched Aug 27:
  `curl -H "Accept: text/markdown" -H "Authorization: token $PULUMI_ACCESS_TOKEN" \
   https://api.pulumi.com/api/insights/adamgordonbell-org/graph/schema`

**Correction.** An earlier version of this file said the Context API had no
docs and should not be mentioned. That was wrong — it was based on the Slack
thread's "Docs: coming soon" (which referred to the docs-site section) plus a
grep that only covered `content/docs/`. The launch blog post shipped the same
day and is merged to master.

**Verified Aug 27: `adamgordonbell-org` has access.** The schema endpoint
returns the primer over HTTP with the stored token.

⚠️ **The local Pulumi CLI is v3.237.0, which is too old for both this and the
editor path.** `pulumi api` needs v3.243.0+, `pulumi neo acp` needs v3.254.0+.
Upgrade before trying either.

**Why it matters here — it is the mechanism behind slide 7.** "Neo already knew
what Pulumi knew" is now a named, queryable thing. From the blog: Neo "uses it
out of the box… ask Neo what breaks if a stack changes, and it queries the graph
on your behalf, with the permissions of the user who invoked it." That last
clause is the same acting-user permission story the CLI-integration section
tells, so the two halves agree.

**⚠️ It also creates a tension with demo 2 that needs handling.** The graph
covers scan-discovered resources (`scope.accounts` on a `resource` anchor,
`includeDiscovered: true`). So an unmanaged security group is, in principle,
findable *without* the AWS CLI — which is the exact thing demo 2 exists to
prove only the CLI can do.

**The primer resolves it, in our favour, in its own words.** Under "Traps that
produce a wrong answer rather than an error":

> Neither flag certifies index freshness. Queries answer from the search index,
> which trails the source of record by ingestion lag: a resource created,
> deleted, or rescanned moments ago can be missing or stale here… When an
> absence answer carries real stakes — deleting "unused" infrastructure, a
> compliance attestation — confirm against stack state before acting.

So the honest distinction is **index versus live**, not "can't see it at all":
the graph is a periodically-ingested index that explicitly disclaims freshness;
the CLI reads the account right now. A security group created minutes ago —
which is exactly what `create-unmanaged.sh` does — is the case the primer says
the index may miss.

**Say it that way on stage.** Do not claim the graph cannot see unmanaged
resources; that is false and someone will know. Claim that a finding with
stakes gets confirmed against live state, which is what the docs themselves
instruct.

Caveats before it goes anywhere near the deck: preview, contract may change,
and **Enterprise/Business Critical only** — a chunk of the audience cannot use
it, so it cannot carry a load-bearing beat.

## Custom Agents — ❓ still unannounced

**Status: not announced.** No `#product-updates` post in 120 days, no docs page, nothing
on the docs site. The only "Custom Agent" strings in the Neo docs are Zed's and JetBrains'
own UI labels on the editors page for adding an ACP agent — unrelated to the Pulumi
feature.

⛔ **The guard in `TODO.md` (Things not to say) stands for Sep 8: do not name it.**

There is internal signal that it is closer than that silence suggests. That signal is
**pre-release and not repeatable here** — this repo ships to attendees. It is written up
in `docs/PLAN.md` and the Things-not-to-say list in `TODO.md`. Read those before deciding anything about either
session's coverage.

**The two-session plan.** Engin's Sep 23 AKS session lands between Sep 8 and his Sep 30
EMEA repeat. So Sep 8 is part one — the integrations story — and Sep 30 can go further if
the feature is public by then. On Sep 8 you may point at the later session and say it goes
deeper; you may not name what it covers. Engin owns that call for his own date, and should
be told the Sep 8 guard is dated rather than left to inherit it.

## How to re-run this check

```bash
~/para/scripts/slack-activity search "Neo" --in product-updates --days 60
~/para/scripts/slack-activity search "integration" --in product-updates --days 60
~/para/scripts/slack-activity search "custom agent" --in product-updates --days 120
```

Then confirm anything promising actually has a docs page before it goes in the
deck — the Context API is the cautionary case.
