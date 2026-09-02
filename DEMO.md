# DEMO.md — the keystrokes

Every demo in the deck, in presentation order, at the level of "what do I type
and what should appear." Written to be readable on a second screen while
presenting.

**This file owns the steps.** [`PRESENTER.md`](PRESENTER.md) owns the clock and
the cut list; [`OUTLINE.md`](OUTLINE.md) owns the argument. If two of them answer
the same question, one of them is wrong.

Conventions used below:

- 🔴 **live** — run in the room · 🎬 **recorded** — a clip plays, nothing to type
- **Say:** a line worth saying out loud · **Don't say:** a claim that won't survive a sharp question
- **Fallback:** what to do when it fails. Decided in advance, never improvised.

| # | Slide | Demo | Kind | Budget |
|---|------:|------|------|--------|
| **1** | **12** | **Context API — how much does Pulumi actually manage?** | 🔴 live | **~90s** |
| | | **— the `ask` movement, slides 19–22, one continuous block ~9 min —** | | |
| 2a | 19 | Connecting one — the clip | 🎬 24s | 1 min |
| 2b | 20 | The integrations page in my org, per-task toggles | 🔴 live | 2 min |
| 2c | 21 | `pulumi neo` — Linear ticket → PR | 🔴 live | 5 min, hard stop 7 |
| 2d | 22 | The receipt — task record → PR | 🔴 live | 90s |
| 3 | 27 | PagerDuty page → merged fix | 🔴 live | 15 min — never cut |
| 4 | 35 | IAM narrowed to least privilege | 🎬 60s | 2 min |
| 5 | 40 | Scheduling an automation | 🎬 18s | 1 min |
| 6 | 41 | The PR that appeared overnight | 🎬 17s | 1 min |

**Why 2a–2d are one thing.** Connecting and using used to sit four slides apart
in different sections — two half-demos. They're now one movement: *what a
connection is* → *how you make one* (clip, can't fail) → *here's mine, really
connected* (live) → *watch it work* (live) → *here's the receipt* (live, and
can't fail either). The slow, fallible part is in the middle, bracketed on both
sides by things that cannot go wrong.

> Demos 2, 4–6 are not written up in full yet. Demos 1 and 3 are below; the rest
> get the same treatment as each one is rehearsed.

---

## Hygiene (once, before you walk on)

**Terminal** — this puts your shell on the projector.

- Fresh window, scrollback cleared, font size up.
- No unrelated env vars, no other orgs, no half-finished commands in history.
- `cd` to the demo directory **now**, so no `cd` happens on stage.

**Browser — ⛔ this one will bite you.** `adamgordonbell-org` is the
**corecursive** account (`adam@corecursive.com`), which is Chrome's *Default*
profile. Chrome also has `v-adam@pulumi.com` (Profile 1) and `agbell@gmail.com`
(Profile 6), and macOS opens a link in the **most recently used** Chrome window.
Every `DemoCta` button in the deck is such a link.

- Open the corecursive profile.
- **Close every other Chrome window** — not just switch away from them.
- Load `app.pulumi.com/adamgordonbell-org` once and confirm the org name on screen.

Get this wrong and slide 20 opens the integrations page of the wrong account,
live.

---

## Demo 1 [slide 12] — 🔴 live — "90% of that account is not Pulumi"

**~90 seconds.** The cheapest live demo in the deck: one read-only HTTP query,
~2 seconds, no model in the loop, no cloud credentials. Good thing to open on —
it buys the room's attention before anything can go wrong.

### Pre-flight

```bash
pulumi version                 # need v3.243.0+ for `pulumi api` — currently v3.259.0
pulumi whoami -v               # expect adamgordonbell-org in Organizations
```

Then, **before anyone is watching**:

```bash
cd ~/sandbox/extending-pulumi-neo/demo/context-api
```

The org is spelled out in every command below rather than hidden behind a
variable — you're literally typing these, and a `$ORG` on the projector is one
more thing the room has to take on faith.

Auth comes from `~/.pulumi/credentials.json`. If `pulumi whoami` works, this works.
The Context API is public preview and gated to Enterprise / Business Critical —
`adamgordonbell-org` qualifies. Nothing else needs to be connected.

⚠️ **Re-run the query the morning of.** The numbers below move. Quoting a stale
count is exactly the kind of thing that gets caught, and the slide has them
printed on it — so if they've moved, the slide is wrong too.

### The steps

**1 — Show the query first.** This is the actual payload of the demo.

```bash
cat coverage-by-tool.json
```

```json
{
  "anchor": { "nodeType": "resource", "limit": 25 },
  "aggregate": {
    "groupBy": ["managed"],
    "metrics": [{ "op": "count", "alias": "n" }]
  }
}
```

**Say:** "Anchor on every resource in the org, group by which IaC tool manages
it, count each group." Six lines. If the room remembers one thing about the
Context API, make it that the query is small enough to read out loud.

**2 — Run it.** Same line the slide shows, character for character.

```bash
pulumi api GraphQuery -F orgName=adamgordonbell-org --input coverage-by-tool.json
```

~2 seconds. 32 lines out, fits one screen, no scrolling — `nodes` comes back
empty because aggregate mode suppresses it.

```json
"aggregations": { "buckets": [
  { "key": { "managed": "Other"  }, "metrics": { "n": 1305 } },
  { "key": { "managed": "Pulumi" }, "metrics": { "n":  144 } } ] }
```

**3 — Land it.** Advance to the slide, which shows 1305 and 144 at full height.

**Say:** "One query, my own org, this morning. About 90% of what's in that
account is not managed by Pulumi. Everything after this slide is about reaching
the other 90%."

### Guardrails

**Say:** `Other` means found by a cloud scan and attributed to no IaC tool. The
closed value set is `ARM`, `CloudFormation`, `Other`, `Pulumi`, `Terraform` — an
org with Terraform in it splits differently. Good aside if asked.

**Don't say:** that the graph can't see unmanaged resources. It can — you found
three unmanaged security groups with `unmanaged-security-groups.json`, and
somebody in the room will know. The real distinction is **index vs live**: the
graph answers from a search index that trails reality, and the API's own primer
says to confirm an absence against the source of record before acting on it.
That's the honest framing, and it's what sets up demo 4.

**Don't say:** "the biggest" about anything from `unmanaged-by-type.json`. Its
`limit` bounds the number of *buckets*, not the resources in them — at
`limit: 15` you get 15 buckets alphabetically.

### Fallback

The slide already has 1305 and 144 on it at full size. If the query fails, keep
talking and advance — the numbers are the argument, not the terminal. Do not
debug a read-only query in front of a room; there is nothing to fix on stage.

### Reset

None. It's read-only and mutates nothing. Safe to run as many times as you like.

### Also in this directory

Not part of demo 1, but one keystroke away if a question earns it:

```bash
pulumi api GraphQuery -F orgName=adamgordonbell-org --input unmanaged-by-type.json          # what kind of thing is unmanaged
pulumi api GraphQuery -F orgName=adamgordonbell-org --input unmanaged-security-groups.json  # 3 of them, all in ca-central-1
```

Full write-up, including the curl form for CLIs older than v3.243.0:
[`demo/context-api/README.md`](demo/context-api/README.md).

---

## Demo 3 [slide 27] — 🔴 live — PagerDuty page → merged fix

**15 min, never cut.** First trigger-to-page run 2026-09-02; times below are
measured, not guessed. The program is its own repo —
[`adamgordonbell/neo-workshop-incident`](https://github.com/adamgordonbell/neo-workshop-incident)
at `demo/pulumi-ts/` — because that remote is where Neo's PR lands.

### Pre-flight (morning of)

```bash
export AWS_PROFILE=work-demo         # every script below needs it
aws sso login --profile work-demo    # expires daily
cd ~/sandbox/extending-pulumi-neo/demo
./prewarm.sh                         # 9 checks, all must be ok; it prints the 4 UI-only ones
```

Plus: GitHub App repo access includes `neo-workshop-incident`.

### The steps

**1 — top of beat 2, second pane** (page takes **2m53s** — SQS metrics reach
CloudWatch at ~1-min granularity — so trigger before the Linear demo, not mid):

```bash
cd ~/sandbox/extending-pulumi-neo/demo && ./trigger-incident.sh
```

```
Poison payment sent to the payment queue.
Message dead-lettered after 2 receive attempt(s).      # ~13s in
```

**2 — beat 3 opens on the incident:** `pulumi-bot-test.pagerduty.com`,
service *Payments*, plus the page email in v-adam@'s inbox.

**3 — main pane:**

```bash
cd ~/sandbox/extending-pulumi-neo/demo/pulumi-ts       # NOT demo/ — Pulumi.yaml + git remote live here
pulumi neo
```

> We're getting paged. Check PagerDuty for the open incident, find out why
> payment messages are dead-lettering, and fix the cause in this program.
> Open a PR.

⚠️ Prompt not locked — anchor it to the incident. Open-ended "figure out
what's wrong" sent Neo chasing a nonexistent security group (2026-09-02).
Expected reads: `pagerduty__browse_incidents`, then `aws` → **FAULT 1**
(`maxReceiveCount: 1`) → redrive-policy PR on `neo-workshop-incident`.

**4 — receipts:** the PR, and the incident auto-resolving in PagerDuty.

### Fallback

A second incident triggered in the morning and left open. Everything down →
the beat's clip, like every beat.

### Reset

```bash
cd ~/sandbox/extending-pulumi-neo/demo && ./cleanup.sh   # purge → alarm OK → auto-resolve; re-arm with trigger
```
