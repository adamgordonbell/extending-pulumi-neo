# DEMO.md — the keystrokes

Every demo in the deck, in presentation order, at the level of "what do I type
and what should appear." Written to be readable on a second screen while
presenting.

**This file owns the steps.** [`PRESENTER.md`](PRESENTER.md) owns the clock and
the cut list; [`OUTLINE.md`](OUTLINE.md) owns the argument. If two of them answer
the same question, one of them is wrong.

Conventions used below:

- 🔴 **live** — run in the room · 🎬 **recorded** — a clip plays, nothing to type
- **Fallback:** what to do when it fails. Decided in advance, never improvised.
- What to say — and not say — lives in [`PRESENTER.md`](PRESENTER.md), not here.

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

**~90 seconds.** One read-only HTTP query, ~2s, no model, no cloud creds.

### Pre-flight

```bash
pulumi version                 # need v3.243.0+ for `pulumi api` — currently v3.259.0
pulumi whoami -v               # expect adamgordonbell-org in Organizations
cd ~/sandbox/extending-pulumi-neo/demo/context-api
```

⚠️ **Re-run the query the morning of** — the counts move, and the slide has
them printed on it.

### The steps

**1 — show the query:**

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

**2 — run it** (same line the slide shows, character for character):

```bash
pulumi api GraphQuery -F orgName=adamgordonbell-org --input coverage-by-tool.json
```

~2s, 32 lines, one screen; `nodes` empty because aggregate mode suppresses it:

```json
"aggregations": { "buckets": [
  { "key": { "managed": "Other"  }, "metrics": { "n": 1305 } },
  { "key": { "managed": "Pulumi" }, "metrics": { "n":  144 } } ] }
```

**3 — advance to the slide** (1305 / 144 at full height).

### Fallback

The numbers are already on the slide — keep talking, advance. Never debug a
read-only query on stage.

### Reset

None; read-only, re-run freely.

### Also in this directory

One keystroke away if a question earns it:

```bash
pulumi api GraphQuery -F orgName=adamgordonbell-org --input unmanaged-by-type.json          # what kind of thing is unmanaged
pulumi api GraphQuery -F orgName=adamgordonbell-org --input unmanaged-security-groups.json  # 3 of them, all in ca-central-1
```

Full write-up + curl form for old CLIs:
[`demo/context-api/README.md`](demo/context-api/README.md).

---

## Demo 3 [slide 27] — 🔴 live — PagerDuty page → merged fix

**15 min, never cut.** Times measured 2026-09-02. The program at
`demo/pulumi-ts/` is its own repo,
[`adamgordonbell/neo-workshop-incident`](https://github.com/adamgordonbell/neo-workshop-incident)
— that remote is where Neo's PR lands.

### Pre-flight (morning of)

```bash
export AWS_PROFILE=work-demo         # every script below needs it
aws sso login --profile work-demo    # expires daily
cd ~/sandbox/extending-pulumi-neo/demo
./prewarm.sh                         # 9 checks, all must be ok; it prints the 4 UI-only ones
```

Plus: GitHub App repo access includes `neo-workshop-incident`.

### The steps

**1 — top of beat 2, second pane:**

```bash
cd ~/sandbox/extending-pulumi-neo/demo
./trigger-incident.sh              # page lands 2m53s later — fire BEFORE the Linear demo
```

```
Poison payment sent to the payment queue.
Message dead-lettered after 2 receive attempt(s).      # ~13s in
```

**2 — beat 3 opens on the incident:** `pulumi-bot-test.pagerduty.com` →
service *Payments*; page email in v-adam@'s inbox.

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
