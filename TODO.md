# TODO — Extending Pulumi Neo (Sep 8, 2026)

Short list. Everything here needs a human — either only you can do it, or we do it together.
Build-only work I can do alone isn't listed; it lives in git.

## Only you can do these

- [x] ~~Ask Engin anything.~~ **Dropped (Adam, Aug 27), draft deleted.** Both
      questions answered without him: a PagerDuty trial covers the demo, and
      Custom Agents are still unannounced (see `docs/since-launch.md`). He
      still presents the **Sep 30 EMEA repeat**, so he needs the deck — and he
      needs telling that the Custom Agents ⛔ may not hold for his date, since
      his Sep 23 AKS session lands between the two runs.
- [x] ~~Start the PagerDuty trial.~~ **Started Sep 2** → expires **Sep 16**; Sep 8
      is day 6. Account `pulumi-bot-test.pagerduty.com`, one user ("Adam Bell",
      `v-adam+pulumi-trail@`, owner) — the account-level API key is the stack
      secret. If Neo's MCP connect wants a *user* token, mint one from that
      user's profile (and optionally rename the user to pulumi-bot for stage
      attribution).
- [x] ~~Connect the integrations~~ **Connected Sep 2** (Adam): PagerDuty MCP
      verified working (Neo read incident #1 via `pagerduty__browse_incidents`).
      Still to verify: **which env the AWS CLI integration points at** — ⛔ must
      be the read-only environment, not `shared/cloud-creds` (AdministratorAccess,
      verified) — and `esc-readonly-role` **has not been deployed yet**, so if
      nothing else was picked, the integration may be on admin creds. Settle
      this with the precedence test below.
- [x] ~~Confirm the org login slug.~~ It's `adamgordonbell-org` (confirmed via
      `pulumi whoami -v`). Slides and `pulumi env run` examples updated.
- [x] ~~Pick the repo remote~~ — **`adamgordonbell/*`**, settled Sep 2 by
      `demo.md`'s clone lines and the `neo-workshop-incident` push. QR can be
      generated once THIS repo passes the pre-public leak pass and pushes.
- [x] ~~Check the live event page duration.~~ pulumi.com said **90 min** on the
      Americas tab (EMEA already said 60). Fixed in
      [pulumi/docs#21175](https://github.com/pulumi/docs/pull/21175) — merge it and
      the page is right. There is no Luma; registration is a gated HubSpot form on
      pulumi.com, delivery is BigMarker `f4d6709a7b01`.

## AWS account — settled

**It's the work demo account.** `616138583583` — the same one your local `work-demo`
SSO profile points at. **ESC → AWS OIDC verified working Aug 25**: `pulumi up` created
an S3 bucket in 5s, `pulumi destroy` removed it.

The credential reasoning — why not `shared/cloud-creds`, what the read-only environment
is for, and how the precedence test is designed — lives in
[`docs/credentials.md`](docs/credentials.md). Don't restate it here.

## Together, Thursday Aug 27 build block

- [x] ~~Upgrade the Pulumi CLI.~~ v3.237.0 → **v3.259.0** (Aug 27). Clears both
      bars: `pulumi api` needs 3.243.0+, `pulumi neo acp` needs 3.254.0+.
      Homebrew needed `brew trust pulumi/tap` first (official tap, already the
      install source).
- [ ] **Time the Context API index lag.** After `create-unmanaged.sh`, run
      `pulumi api GraphQuery -F orgName=adamgordonbell-org --input unmanaged-security-groups.json`
      (from `demo/context-api/`) on a clock and
      find out how long the scan takes to notice the new group. The demo-2 beat
      depends on the answer: index-behind-live if slow, "here's when it
      noticed" if fast. Don't script the punchline until this is measured.
- [x] ~~`pulumi up` `demo/pulumi-ts`~~ **Deployed, rehearsed end-to-end, and torn
      down again — all Sep 2.** Full chain worked: trigger → page (2m53s) → Neo
      read the incident over MCP → fix PR. PR #1 **closed unmerged** (⛔ never
      merge a fault-fix PR before the Sep 30 EMEA repeat — merging un-plants
      FAULT 1). Stack config survives teardown; re-setup is `pulumi up` (~5 min)
      + two triggers, morning of Sep 8. The code now lives in its own repo:
      `adamgordonbell/neo-workshop-incident` (checkout at `demo/pulumi-ts`,
      gitignored — keep it on `main`, the branch with the bug).
- [ ] `pulumi up` **`esc-readonly-role`** (now in the incident repo). Still only
      typechecks — and the AWS CLI integration needs its env (see above).
- [ ] **Credential-precedence test.** The open question: when `pulumi neo` runs
      locally and asks for `aws`, does it resolve the org's ESC integration or
      your laptop credentials? Docs don't say. The read-only role makes this
      decidable — if it can't write, ESC won.
- [ ] **Decide beat 5** — scheduled automations, or the editor integration.
- [ ] **Arm the unmanaged-resource finding**: `demo/create-unmanaged.sh` after
      `pulumi up`, then confirm Pulumi can't see it —
      `pulumi stack --show-urns | grep -i security` should print nothing.
      Reset between rehearsals with `demo/cleanup.sh` (calls
      `remove-unmanaged.sh`), re-arm with `create-unmanaged.sh`.
- [ ] **Decide: does the scope section keep the IAM video, or lean on demo 2?**
      Demo 2 now surfaces an unmanaged resource, which makes the scope argument
      live rather than recorded. The `iam-narrow` video may now be redundant.
      Judge it in the run-through.
- [ ] **A 5th QR: sign up / try Neo.** Slides 7–8 now tell the room to go play with
      it, and the closing slide has no way to act on that. Add one to
      `scripts/make-qr.py` alongside repo / blog / docs / EMEA.
- [ ] **Time the opening.** The stage-setter is budgeted at 90s + 30s. `why` was
      already the shortest beat; check it hasn't eaten into `ask`.
- [ ] Full run-through against the clock. 60 minutes, two live demos.

## The `ask` movement — what it still needs

Restructured Aug 27 (slides 19–22). Three loose ends:

- [ ] **Tape your own Linear run.** `neo-linear.mp4` isn't your footage and is
      no longer wired in as the fallback. You'll run this repeatedly in
      rehearsal, so the clip is free — capture one good complete run and make it
      the safety net for slide 21.
- [ ] **Consider re-taping the connect clip with Linear.** Slide 19 currently
      shows Honeycomb being connected and slide 21 uses Linear. Nobody may
      notice, but same-integration would make the movement seamless — and you'll
      be in that UI anyway.
- [ ] **Slide 22's PR link is a placeholder** (`neo-examples#5`). Swap it for
      whatever the rehearsal run actually opens, so the receipt is a receipt for
      the thing they just watched.

## Polish pass — de-risk the demos, then make the slides visual

Adam, Aug 27: not today, but this is the shape of the remaining work. Two passes,
in this order — the demo decisions change what the slides have to say.

**1. Lower the lift at presentation time.** The goal is that nothing on stage
depends on a model finishing a task while 200 people watch.

- [ ] **Decide live vs recorded per demo, deliberately.** Currently three live
      (slide 12 Insights, 20 Linear, 25 PagerDuty) and four recorded (16, 33,
      38, 39). Every live one is a place the clock can run away.
- [ ] **Pre-bake Neo sessions to walk through** rather than start cold. A
      finished session with visible task history, opened and read aloud, shows
      the same thing as a live run and costs seconds instead of minutes. This
      overlaps with "Neo Cloud sessions to recreate" below — same work, and it
      now has a second reason.
- [ ] **Prefer artifacts over runs.** A merged PR is instant, permanent, and
      can't fail; the deck already links four. Where a beat can end on a PR
      instead of a completion, it should.
- [ ] **Tape more in Neo while the demos are being built**, not after. Every
      real run is a free clip if it's being captured at the time.

**2. Make the recorded clips look legit.** Right now they don't fill the frame:

| clip | size | aspect | duration |
|---|---|---|---|
| honey-comb | 1440×1080 | 4:3 | 24s |
| iam-narrow | 1686×868 | ~1.94:1 | 60s |
| neo-schedule-setup | 1440×1080 | 4:3 | 18s |
| neo-cis-pr | 1440×864 | 5:3 | 17s |
| neo-linear (fallback) | 1736×1080 | ~1.6:1 | 76s |

- [ ] **Re-export, don't re-record — the Screen Studio raws are still here.**
      All six clips came from the "10 more things" blog post (they're in
      `~/sandbox/docs/content/blog/10-more-things-you-can-do-with-neo/`, shipped
      May 19 2026), sized for an inline blog figure. That's the whole reason
      none of them are 16:9.
      `~/Screen Studio Projects/` holds 8 bundles, 4.7 GB, captured at retina
      (2560×1600 → 3840×2160) — including `deploy-to-aws.screenstudio` and its
      `-edited` sibling, near-certainly the source of `deploy-to-aws2.mp4`, plus
      three Chrome captures from May 11–15 that bracket the blog post's date.
      ⚠️ **The 1:1 mapping is unconfirmed** — the bundles are named app +
      timestamp and their fragmented MP4s don't probe for duration. Opening the
      8 projects in Screen Studio is the quick way to match them to clips.
      If they match, this stops being a re-record and becomes a re-export at
      1920×1080 with the framing/zoom set in the editor — hours cheaper.
      Nothing is in the Beta app's store (9 MB, raws long gone).
- [ ] **`neo-linear.mp4` is not Adam's footage — replace it, don't re-export.**
      Adam, Aug 27: "the linear one wasn't by me, that is for sure." The file
      metadata agrees. The other five clips were all muxed by `Lavf61.7.100`
      and carry a stream-level `Lavc61.19.101 libx264` encoder tag; `neo-linear`
      was muxed by `Lavf59.16.100` and carries no stream encoder tag at all —
      a different pipeline. It's also 30fps at 1.6 Mbps against a house style of
      20fps at 0.4–0.7 Mbps, and it's the only clip with no candidate raw in
      `~/Screen Studio Projects/`.
      ⚠️ This matters more than the framing: the deck uses it as the **fallback
      for the live Linear demo** (slide 20 notes — "play /video/neo-linear.mp4
      (76s), it's the same thing"). A fallback you reach for under time pressure
      should not be someone else's screen and someone else's org. Re-tape it —
      which is the same work as pre-baking the Linear demo, already on this list.
- [ ] **Hide the chrome.** `iam-narrow`'s notes already say Chrome is hidden;
      make that the rule for all of them — no tab bar, no bookmarks, no dock.
- [ ] **Zoom the app, not the video.** Browser zoom before capture keeps text
      sharp; scaling a small capture up on the slide does not.

**3. Then the visual pass on the slides.** Many are still paragraphs.

- [ ] Go slide by slide and cut prose to the one thing being said out loud,
      moving the rest into speaker notes. **The notes are the presenter's
      script — losing them to make a slide pretty is a regression, not a win.**
      Every fact that tells Adam how to walk the beat stays in the deck, just
      below the fold rather than on the wall.
- [ ] Reach for the three-box map on slide 8 as the pattern: it replaced a
      bullet list and carries more.

## ⛔ Before this repo goes public

The repo ships to attendees (QR on the closing slide) and **has no remote yet** — which
makes now the cheap moment to decide, since git history is permanent once pushed.
Adam's call (Aug 27): keep everything here for working, clean up before release.

Scanned Aug 27, tracked files that need a pass:

- [ ] **`docs/PLAN.md`** — the worst of it. Eight internal Slack permalinks including a
      **private DM**, a section headed "all internal, pre-launch", and an unannounced
      **September "agent teams" launch**. It's already marked superseded; the simplest
      answer is to drop it from the published tree rather than redact it line by line.
- [ ] **AWS account `616138583583`** appears in `TODO.md`, `docs/PLAN.md`,
      `docs/credentials.md`. Not a secret, but not for broadcast — swap for a placeholder.
- [ ] **`docs/since-launch.md`** — four internal Slack permalinks. The *facts* are public
      (blog posts, changelog, docs); re-cite them to the public sources and drop the links.
- [ ] **`INTERNAL.md`** — already gitignored, keep it that way. Pre-release Custom Agents
      detail; nothing in it may reach a slide, the README, or the stage.
- [ ] Re-run the check before pushing:
      `git grep -niE "slack.com|616138583583|pre-launch|agent teams"`

## Linkable artifacts

Demo slides now carry a click-through button, so each one needs a real URL.

**PRs that already exist** (wired into the deck):

| Slide | PR | State |
|---|---|---|
| Every demo ends in a PR | [neo-examples#9](https://github.com/adamgordonbell/neo-examples/pull/9) — restrict bastion SSH to VPC | merged |
| Unused resources | [neo-examples#7](https://github.com/adamgordonbell/neo-examples/pull/7) — remove 3 unused resources | merged |
| Burst capacity | [neo-examples#5](https://github.com/adamgordonbell/neo-examples/pull/5) — add burst node group | merged |
| IAM narrowing | [iam-narrow-demo#1](https://github.com/adamgordonbell/iam-narrow-demo/pull/1) — narrow to least privilege | closed |

`iam-narrow-demo#1` is closed rather than merged. Fine to click into — the diff
and the evidence-in-the-PR-body point both still read — but don't call it merged
on stage.

- [ ] **Neo Cloud sessions to recreate.** The PRs survived; the sessions behind
      them didn't leave links in the PR bodies. For the "browse previous sessions,
      then show the PRs they produced" slide we need 3–4 sessions in the demo org
      with visible task history. Recreating them also re-runs the work, which
      would produce fresh PRs we could link instead of the old ones.
      Worth doing on Aug 27 if there's time; the slide degrades to just the PRs
      if not.
