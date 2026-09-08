# TODO — Extending Pulumi Neo (Sep 8, 2026)

The plan of record for what is left, plus everything the presenter needs on the day.
Reconciled **Sep 4** after the spine restructure (`INTERNAL.md` folded in here and
deleted; the repo stays private so nothing here needs hiding).

Deck: 36 slides, `slides/slides.md`, Slidev on `localhost:3030`. Spine (one line per
slide, the speaker notes are these lines): `~/para/scratch/neo-workshop-causal-chain.md`.

## What's left, in order

### 0. Demo verification — DONE Sep 4 (Claude ran `demo.md` end to end)

| Step | Result | Time |
|---|---|---|
| `pulumi up` + `add-db-sg.sh` + `prewarm.sh` | 16 resources, 9/9 ok | 5 min |
| Context API query | 1305 / 144, matches slide 13 | seconds |
| Linear ticket → PR #3 + comment on PUL-5 | passed | 4 min 36 s |
| trigger → PagerDuty page | passed | 2 min 33 s |
| Incident → PR #4 (redrive fix + adopted security group) | passed, interactive TUI | 10 min 30 s |

Neo found the planted security group, stated the mitigating factor, and adopted-and-
narrowed it in the same PR. It asked two questions on the way (see `demo.md`).
`pulumi neo -p` (print mode) is unusable for the incident: it exits on a spurious
"final" flag mid-task, twice. Use the interactive TUI on stage.

### 1. Timed run-through against the clock (Adam)

- [ ] **Full run-through, 60 minutes.** Three live moments verified above; three clips;
      two click-throughs. Before starting: reset per item 2, then the morning-of block.
- [ ] **What to say during the waits.** Linear is ~5 min of Neo working, the incident
      ~10 min with two prompts to answer. Decide the narration (the tool-call stream is
      the content) and whether to kick the Linear task off at the map slide.
- [ ] **After the run-through, delete the eleven hidden slides** or restore keepers.
      `hide: true` in `slides/slides.md`: It's a toggle · Every demo ends the same way ·
      ask / delegate / scope dividers · Connecting one · Here's mine · The receipt ·
      What's a toggle now · So what can this thing reach · `pulumi env run` · Least
      privilege setup · In your editor.

### 2. Reset before every rehearsal and before Sep 8

Today's run left residue that would change what Neo does next time.

- [ ] **Linear ticket PUL-5:** delete Neo's two PR-link comments (Sep 2, Sep 4) and confirm
      status is still Todo. Otherwise Neo may point at the existing PR instead of working.
      Or file a fresh ticket and repoint the slide 17 button. Browser only; the Linear key
      lives in the Neo integration.
- [x] **Incident repo PRs:** #1–#4 all closed unmerged (Sep 4). The fault stays planted. The
      live run on the day opens a fresh one; show that.
- [x] **Stack:** destroyed Sep 4 after the run (0 resources), config kept. Morning-of re-up per
      the block below; the security group is re-planted by that block. Teardown order is
      `cleanup.sh` then `destroy`; both scripts were fixed today (incident repo 8a020f7, eceb855).

### 2b. Answer key — stripped Sep 4

Both Sep 4 runs read `index.ts`, `FINDINGS.md` and the security-group script within the
first minute, and all three named the faults. Incident repo 199eacd removed the header
paragraph and the `FAULT` comments from `index.ts` (code unchanged, tsc clean), moved
`FINDINGS.md` to `docs/FINDINGS.md` here, and renamed the scripts to `add-db-sg.sh` /
`remove-db-sg.sh` with neutral headers. The run-through (item 1) is the first run against
the clean checkout; if Neo still lands on `maxReceiveCount` it earned it.

### 3. Credentials — settled Sep 4: say less

Slide 23 now says "you choose the role" rather than "as I did." The read-only ESC role,
the aws CLI integration and the precedence test are not being built for Sep 8. Reasoning
in `docs/credentials.md` if it ever comes back. The Sep 4 run read AWS via
`pulumi env run adamgordonbell-org/payments/dev`, an admin role Neo picked itself.

### 4. Assets

- [ ] **Re-tape the Linear fallback.** `neo-linear.mp4` is not Adam's footage. Every
      rehearsal run is a free capture; keep one.
- [ ] **Clip re-exports to 16:9**, optional. Raws probably in `~/Screen Studio Projects/`.
- [ ] **Scan the thanks slide once with a phone.** Six codes, all decode-verified Sep 4.

### 5. People and pages — done

- [x] Engin: nothing to send. He is on vacation; the deck lives in this repo and the Custom
      Agents note is under Things not to say. He picks it up for Sep 30 on his own.
- [x] [pulumi/docs#21175](https://github.com/pulumi/docs/pull/21175) merged; event page says 60 min.

### 6. Repo

- [ ] Commit and push (private remote). The repo is not shared with attendees.
- If that ever flips: drop `docs/PLAN.md`, placeholder account `616138583583` in
  `docs/credentials.md`, re-cite `docs/since-launch.md`, and
  `git grep -niE "slack.com|616138583583|pre-launch|agent teams"` first.

## Stage

### Morning-of pre-flight

```bash
export AWS_PROFILE=work-demo && aws sso login --profile work-demo
pulumi login && pulumi whoami -v        # expect org: adamgordonbell-org
cd ~/sandbox/extending-pulumi-neo/demo/pulumi-ts && pulumi up && ./add-db-sg.sh && ./prewarm.sh
cd ../context-api && pulumi api GraphQuery -F orgName=adamgordonbell-org --input coverage-by-tool.json
pulumi api GraphQuery -F orgName=adamgordonbell-org --input old-provider-blast-radius.json   # payments pipeline should now be in it
pulumi api GraphQuery -F orgName=adamgordonbell-org --input safe-to-upgrade-first.json       # leaves of the payments stack
```

- [ ] PagerDuty trial alive (started Sep 2, dies Sep 16; Sep 8 is day 6)
- [ ] PagerDuty + Linear MCP connected in the org; ticket PUL-5 open and waiting
- [ ] Context API counts re-run; slide 13 has 1305 / 144 printed on it, fix if moved
- [ ] The four Neo questions in demo.md §1 asked once against the live stack; note the answers in demo/context-api/README.md. Impact + cleanup only mean anything with the stack up
- [ ] Trigger TWICE: resolve one as rehearsal, keep one open as the spare
- [ ] Click every demo button once, logged in, right account: Integrations, the Linear
      ticket, PagerDuty incidents, both Neo task links, the runbook PR, the trail PRs
- [ ] Terminal: fresh window, cleared scrollback, font up, cd'd to `demo/pulumi-ts`
- [ ] **Chrome-profile trap.** `adamgordonbell-org` = corecursive account = Chrome
      *Default* profile. Close every other Chrome window; macOS opens slide links in the
      most recent one. Load `app.pulumi.com/adamgordonbell-org` once and check the org.

### Clock (60 min)

| Beat | Slides | Target |
|---|---|---|
| Open: what Neo is, day two, go play, the map | 5–8 | 12:02–12:05 |
| What it knows: Context API query | 9–13 | 12:05–12:07 |
| What it can reach: Linear ticket (~5 min of Neo) · ⏱ fire `trigger-incident.sh` at the top | 14–18 | 12:07–12:14 |
| The incident (~10½ min of Neo, two questions to answer) | 19–21 | 12:14–12:34 |
| The reach question: four CLIs, read-only, per-task off | 22–24 | 12:34–12:40 |
| Where it runs: IAM clip, schedule, next morning, runbook | 25–30 | 12:40–12:50 |
| So what, the trail, where next, thanks | 31–36 | 12:50–12:53 |
| Q&A | | 12:53–1:00 |

Cuts if long, in order: Where this goes next · More reading · the IAM clip · the
schedule beat down to one slide plus its clip. **The incident never gets cut.**

### When it breaks

- Integration missing from the composer: Neo skips it and continues. Say so, keep going.
- Neo can't run the CLI: `pulumi env run <ref> -- <cli> <args>`, one debug attempt max.
- Page never fires: the spare incident from the morning.
- Linear demo stalls: one retry, then `neo-linear.mp4`, switch without apologizing.
- Neo wanders off-incident (Sep 2: chased a nonexistent security group): redirect once,
  "verify that before chasing it, the incident is about the DLQ."
- Everything down: every beat has its clip in `slides/public/video/`.

### Things not to say

- The MCP integration does not replace Engin's webhook: reading half only; auto-starting
  a task on a page still needs his glue. (Slide "What's a toggle now" is hidden; if asked,
  this is the answer.)
- Don't claim the credentials were read-only. "You choose the role" is the line.
- Don't say the Context API can't see unmanaged resources; it can. The honest distinction
  is index vs live.
- Don't say Neo is free. "On by default if you have an org" is the true claim.
- Don't say "MCP reads, CLI runs": Neo writes over MCP (resolves the incident, comments
  on the ticket).
- IAM PR #1 is closed, not merged. Drift PR #1 is open, leave it open.
- **Do not name Custom Agents.** Unannounced, flagged off, code in review (internal
  detail in `docs/PLAN.md`). Safe: point at Sep 30 as "part two, it goes further," no
  feature name. Engin owns whether it is sayable on his date.
- Where next: "they've said next," not "coming soon."

### Rerun prompts

**Drift PR** (neo-drift-demo, after `pulumi up` and
`aws iam put-role-policy --role-name audit-reader --policy-name AllowReadAuditLogs --policy-document '<GetObject+ListBucket on audit-logs-*>'`):

```
pulumi neo -p --approval-mode balanced --org adamgordonbell-org -s prod-audit "Run today's
drift check for the prod-audit stack. Compare live AWS state to the program and find any
resource whose live state differs from what the program declares. Note that pulumi refresh
will not surface inline policies the program does not declare, so check live state with the
aws CLI. For each drifted resource, follow infra/runbooks/drift.md and cite the section you
followed. If the runbook says to encode the change, make it in this program, verify with
pulumi preview, and open a PR. The PR body must include: a summary, what changed, how it was
detected, the runbook decision with the section quoted, and the preview result."
```

Took ~7 min on Sep 2. Authored by Adam's GitHub user, not pulumi[bot].

## Settled (don't re-open)

- **Spine (Sep 4):** three categories, knows / reaches / runs. Ask, delegate, scope are not
  groups; their dividers are hidden. The IAM clip is the terminal example under runs. The
  editor is one line on "Same agent, four places," no slide, no demo. The 13→14 transition
  is parallel ("that is the first category"), not causal.
- **Demo slides** carry `class: demo`, title plus buttons, never the finding. Speaker notes
  are the spine line only. Old notes: commit `e9b8a6d`.
- **Runbook demo** is a click-through of the real drift PR, not a typed demo.
- **Repo stays private.** Closing slide: Adam + Engin cards with LinkedIn QRs, plus Ten
  More Things, integrations docs, EMEA.
- **PagerDuty trial** started Sep 2, expires Sep 16. Account `pulumi-bot-test.pagerduty.com`,
  one user (`v-adam+pulumi-trail@`, owner); the account-level key is the stack secret.
- **Linear** test workspace `agb-demo-test`, ticket
  <https://linear.app/agb-demo-test/issue/PUL-5/add-versioning-to-the-staging-bucket>.
- **Incident demo** proven end to end Sep 2: trigger → page in 2m53s → Neo read it over
  MCP → fix PR. Code in `adamgordonbell/neo-workshop-incident` (checkout at
  `demo/pulumi-ts`, gitignored, stays on `main`). Stack destroyed, config kept.
  ⛔ Never merge a fault-fix PR before Sep 30 (un-plants FAULT 1).
- **Drift demo** is real: `adamgordonbell/neo-drift-demo` (prod-audit stack). PR #1 cites
  the runbook; infra destroyed after, stack kept empty. ⛔ Leave PR #1 open.
- **AWS account** is the work demo account (`work-demo` SSO profile); ESC → AWS OIDC verified.
- **Pulumi CLI** v3.259.0. **Org** `adamgordonbell-org` = corecursive Google account =
  Chrome *Default* profile. **Repo remotes** all `adamgordonbell/*`.
- **Event page:** gated HubSpot form on pulumi.com, delivery BigMarker `f4d6709a7b01`.

## Linkable artifacts (all wired into the deck)

| Slide | Link | State |
|---|---|---|
| 17 Linear demo | Integrations page · ticket PUL-5 | |
| 18 What just happened | Neo task `40c356f4` | |
| 20 PagerDuty demo | `pulumi-bot-test.pagerduty.com/incidents` | |
| 27 IAM clip; 33 trail | [iam-narrow-demo#1](https://github.com/adamgordonbell/iam-narrow-demo/pull/1) | closed (say closed) |
| 29 next morning; 33 trail | [neo-examples#9](https://github.com/adamgordonbell/neo-examples/pull/9) restrict bastion SSH | merged |
| 30 runbook; 33 trail | [neo-drift-demo#1](https://github.com/adamgordonbell/neo-drift-demo/pull/1) · Neo task `9dd90791` | open, leave open |
| 33 trail | [neo-examples#7](https://github.com/adamgordonbell/neo-examples/pull/7) · [#5](https://github.com/adamgordonbell/neo-examples/pull/5) | merged |
| (rehearsal only) | [neo-workshop-incident#2](https://github.com/adamgordonbell/neo-workshop-incident/pull/2) bucket versioning · [#1](https://github.com/adamgordonbell/neo-workshop-incident/pull/1) dead-lettering | open · closed |

Neo tasks in the org from Sep 2: drift check `9dd90791`, CIS benchmark ×2, Linear ticket
`40c356f4`, dead-lettering fix `e6747aa4`, PagerDuty investigation `60843786`.
