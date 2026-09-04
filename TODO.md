# TODO — Extending Pulumi Neo (Sep 8, 2026)

The plan of record for what is left. Reconciled **Sep 2, late** after the build day.
Everything here needs a human; build-only work lives in git. Presenter-only staging
(clock, cuts, per-slide don'ts, rerun prompts) is in the gitignored `INTERNAL.md`.

## What's left, in the order it should happen

### 1. Timed run-through (the one that decides the rest)

- [ ] **Full run-through against the clock.** 60 minutes, three live moments (Context
      API query, Linear, PagerDuty), four clips. Needs the incident stack up first
      (`pulumi up` in `demo/pulumi-ts`, ~5 min) and a trigger at the top of the ask beat.
- [ ] **Decide the ask / delegate / scope dividers.** Still in; Adam wanted to judge them
      in the walk-through. The corner strip only tracks the five big sections, so hiding
      them breaks nothing.
- [ ] **Judge scope at four slides** (divider, Four of them, reads-with-CLI, per-task
      toggles). If it feels thin, the hidden `pulumi env run` slide comes back once the
      read-only claim is true (item 3).
- [ ] **Then delete the seven hidden slides** or un-hide the keepers. They are `hide: true`
      in `slides/slides.md`; list in `INTERNAL.md`.

### 2. The unmanaged-security-group beat (decide, don't leave conditional)

The incident demo's notes and the delegate "What just happened" slide still mention a
security group open on 5432 that no program describes. It only exists if
`create-unmanaged.sh` has been run, and in the Sep 2 rehearsal Neo invented one.

- [ ] **Arm it or cut it.** Arm: `create-unmanaged.sh` after `pulumi up`, confirm
      `pulumi stack --show-urns | grep -i security` prints nothing, and add the nudge
      prompt to the rehearsal. Cut: drop the bullet from the slide and the two lines from
      the notes.
- [ ] **If armed, time the Context API index lag** (`unmanaged-security-groups.json` on a
      clock) so the "index vs live" line in the notes is measured, not guessed.

### 3. Credentials: make the read-only story true, or say less

Slide "It reads with the CLI" now says "give it a read-only role, as I did." On Sep 2 the
local `pulumi neo` runs used ambient admin credentials with no aws CLI integration
connected. Reasoning in `docs/credentials.md`.

- [ ] `pulumi up` **`esc-readonly-role`** (in the incident repo). Still only typechecks.
- [ ] **Connect the aws CLI integration to that environment** (⛔ not `shared/cloud-creds`).
- [ ] **Precedence test:** with the integration on, does a local `pulumi neo` use the ESC
      role or the laptop creds? Read-only makes it decidable. Until then, the slide's "as I
      did" is the thing to soften.

### 4. Assets

- [ ] **Editor slide has no demo.** Clip or talking slide; the Aug 27 plan was a Zed clip.
      Decide in the run-through. A clip is safer than a fourth live surface.
- [ ] **Re-tape the Linear fallback.** `neo-linear.mp4` is not Adam's footage (different
      encoder pipeline, different org). Every rehearsal run is a free capture; keep one.
- [ ] **Clip re-exports to 16:9**, optional polish. Raws are probably in
      `~/Screen Studio Projects/` (8 bundles, mapping unconfirmed; open them to match).
      Hide the chrome, zoom the app not the video.
- [ ] **QR codes.** The closing slide's repo QR points at `github.com/PLACEHOLDER`.
      Regenerate with `scripts/make-qr.py` once this repo is public (item 5), and add a
      5th QR for "go try Neo" (app.pulumi.com) since slide 7 tells the room to.
- [x] ~~Verify the Neo task URL shape.~~ Confirmed by Adam Sep 3:
      `app.pulumi.com/adamgordonbell-org/neo/tasks/<task-id>`. Deck links the drift
      session (9dd90791) and the Linear session (40c356f4).

### 5. ⛔ Before this repo goes public

Attendees clone it (QR on the closing slide). Scanned Aug 27; still to do:

- [ ] **`docs/PLAN.md`** — eight internal Slack permalinks incl. a private DM, an
      "all internal, pre-launch" section, an unannounced launch. Drop it from the tree.
- [ ] **AWS account `616138583583`** in `docs/PLAN.md`, `docs/credentials.md` → placeholder.
- [ ] **`docs/since-launch.md`** — four internal Slack permalinks; re-cite to public sources.
- [ ] `INTERNAL.md` stays gitignored.
- [ ] Before pushing: `git grep -niE "slack.com|616138583583|pre-launch|agent teams"`
- [ ] Commit `slides/` and push; then QR.

### 6. People and pages

- [ ] **Engin needs the deck and a heads-up** for Sep 30: part two, and the Custom Agents
      ⛔ may not hold for his date. Adam sends.
- [ ] **Merge [pulumi/docs#21175](https://github.com/pulumi/docs/pull/21175)** so the
      Americas event page says 60 min, not 90.

### 7. Morning of Sep 8

Checklist with commands is in `INTERNAL.md` (pre-flight). Headline: `pulumi up` the
incident stack, trigger twice (resolve one, keep one spare), re-run the Context API
counts, click every demo button once in the right Chrome profile.

## Settled (don't re-open)

- **PagerDuty trial** started Sep 2, expires Sep 16 (Sep 8 = day 6). Account
  `pulumi-bot-test.pagerduty.com`, one user (`v-adam+pulumi-trail@`, owner); the
  account-level key is the stack secret. MCP verified: Neo read incident #1.
- **Linear** test workspace `agb-demo-test`, ticket
  <https://linear.app/agb-demo-test/issue/PUL-5/add-versioning-to-the-staging-bucket>.
- **Incident demo** proven end to end Sep 2: trigger → page in 2m53s → Neo read it over
  MCP → fix PR. Code lives in `adamgordonbell/neo-workshop-incident` (checkout at
  `demo/pulumi-ts`, gitignored, stays on `main`). Stack destroyed, config kept; re-up is
  one `pulumi up`. ⛔ Never merge a fault-fix PR before Sep 30 (un-plants FAULT 1).
- **Drift demo** is real: `adamgordonbell/neo-drift-demo` (prod-audit stack, bucket +
  `audit-reader` role + `infra/runbooks/drift.md`). Local `pulumi neo -p` drift check opened
  PR #1 citing the runbook; infra destroyed after, stack kept empty. ⛔ Leave PR #1 open (it
  is an import; the role is gone). Rerun prompt in `INTERNAL.md`.
- **AWS account** is the work demo account (`work-demo` SSO profile); ESC → AWS OIDC verified.
- **Pulumi CLI** v3.259.0 (needs 3.254+ for `pulumi neo acp`).
- **Org** is `adamgordonbell-org` = the corecursive Google account = Chrome *Default* profile.
- **Repo remotes** are all `adamgordonbell/*`.
- **Event page:** gated HubSpot form on pulumi.com, delivery BigMarker `f4d6709a7b01`, no Luma.
- **Deck conventions (Sep 2):** one `demo.md` tutorial, no presenter script; speaker notes are
  talking points only; demo slides carry `class: demo` (tint + bar + watermark) and show
  title + one button, never the finding; clips go full screen on click.
- **Beat 5** is settled: both the editor and scheduled tasks have slots in `runs`.
- **IAM clip stays** (Adam likes it); scope leans on it plus per-task toggles.

## Linkable artifacts (all wired into the deck)

| Where | Link | State |
|---|---|---|
| Runs · next morning; trail | [neo-examples#9](https://github.com/adamgordonbell/neo-examples/pull/9) restrict bastion SSH | merged |
| Trail | [neo-examples#7](https://github.com/adamgordonbell/neo-examples/pull/7) remove unused resources | merged |
| Trail | [neo-examples#5](https://github.com/adamgordonbell/neo-examples/pull/5) burst node group | merged |
| Scope · IAM clip; trail | [iam-narrow-demo#1](https://github.com/adamgordonbell/iam-narrow-demo/pull/1) narrow IAM | closed (say closed) |
| Runs · runbook; trail | [neo-drift-demo#1](https://github.com/adamgordonbell/neo-drift-demo/pull/1) encode inline policy | open, leave open |
| Ask · what just happened | [neo-workshop-incident#2](https://github.com/adamgordonbell/neo-workshop-incident/pull/2) staging bucket versioning | open, leave open |
| (rehearsal only) | [neo-workshop-incident#1](https://github.com/adamgordonbell/neo-workshop-incident/pull/1) fix dead-lettering | closed unmerged |

Neo tasks in the org from Sep 2 (visible task history, so the "browse sessions" idea is
now possible): drift check `9dd90791`, CIS benchmark ×2, Linear ticket `40c356f4`, dead-
lettering fix `e6747aa4`, PagerDuty investigation `60843786`.
