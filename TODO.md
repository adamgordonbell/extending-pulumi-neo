# TODO — Extending Pulumi Neo (Sep 8, 2026)

Short list. Everything here needs a human — either only you can do it, or we do it together.
Build-only work I can do alone isn't listed; it lives in git.

## Only you can do these

- [ ] **Start the PagerDuty trial — on or after Thu Aug 27.** Trial is 14 days.
      Aug 27 + 14 = Sep 10, so Sep 8 lands on day 12. Starting it any earlier
      expires it before or on the workshop. Sign up as the `pulumi-bot` user.
- [ ] **Connect the integrations** in the demo org (Settings → Integrations):
      PagerDuty, Linear, and one of Datadog/Honeycomb. Org-admin only.
- [ ] **Confirm the org login slug.** Slides and `pulumi env run` examples assume
      `adam-gordon-bell-org`. If it's different, one find-and-replace fixes it.
- [ ] **Send the questions to Engin** — draft is at `docs/engin-ask.md`, not sent.
- [ ] **Pick the repo remote** — `adamgordonbell/*` or under `dirien/*`.
      Blocks the repo QR code on the closing slide.
- [ ] **Check the live event page + Luma copy** still say 90 minutes. It's 60.

## Together, Thursday Aug 27 build block

- [ ] `pulumi up` both programs — `demo/pulumi-ts` and `demo/esc-readonly-role`.
      Neither has been deployed; they only typecheck.
- [ ] **Credential-precedence test.** The open question: when `pulumi neo` runs
      locally and asks for `aws`, does it resolve the org's ESC integration or
      your laptop credentials? Docs don't say. The read-only role makes this
      decidable — if it can't write, ESC won.
- [ ] **Decide beat 5** — scheduled automations, or the editor integration.
- [ ] Full run-through against the clock. 60 minutes, two live demos.

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
