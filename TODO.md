# TODO — Extending Pulumi Neo (Sep 8, 2026)

Short list. Everything here needs a human — either only you can do it, or we do it together.
Build-only work I can do alone isn't listed; it lives in git.

## Only you can do these

- [ ] **Start the PagerDuty trial — on or after Thu Aug 27.** Trial is 14 days.
      Aug 27 + 14 = Sep 10, so Sep 8 lands on day 12. Starting it any earlier
      expires it before or on the workshop. Sign up as the `pulumi-bot` user.
- [ ] **Connect the integrations** in `adamgordonbell-org` (Neo Settings →
      Integrations). Org-admin only. Two sections, connected separately:
      - **MCP tools:** PagerDuty, Linear, and one of Datadog/Honeycomb.
      - **CLI tools:** AWS → point it at the **new read-only** environment.
      ⛔ **Do NOT point the AWS CLI integration at `shared/cloud-creds`.** That
      environment assumes `pulumi-environments-oidc`, which has
      **AdministratorAccess** (verified). Connecting it would make the
      read-only claim on stage false and make the precedence test undecidable.
- [x] ~~Confirm the org login slug.~~ It's `adamgordonbell-org` (confirmed via
      `pulumi whoami -v`). Slides and `pulumi env run` examples updated.
- [ ] **Send the questions to Engin** — draft is at `docs/engin-ask.md`, not sent.
- [ ] **Pick the repo remote** — `adamgordonbell/*` or under `dirien/*`.
      Blocks the repo QR code on the closing slide.
- [ ] **Check the live event page + Luma copy** still say 90 minutes. It's 60.

## ⚠️ Decide first: which AWS account the workshop runs in

**Verified Aug 25 — ESC → AWS OIDC works.** `pulumi up` created an S3 bucket in
5s and `pulumi destroy` removed it, driven by `shared/cloud-creds`. The
mechanism is sound. The account is the problem.

`shared/cloud-creds` assumes `pulumi-environments-oidc` in account
**616138583583**, which is a **member of Pulumi's corporate AWS organization**
(master `153052954103`, `joe@pulumi.com`). It has no account alias and is full
of CI leftovers — dozens of `*-tf-test-bucket` and timestamp-named buckets.
The role carries **AdministratorAccess**.

That's a shared corporate account, with admin, on a recorded session where the
terminal is on screen. Three things follow:

- `aws s3 ls` on stage lists every bucket in a corporate account. Assume
  anything Neo prints is visible.
- The read-only role program (`demo/esc-readonly-role/`) currently deploys
  *into* that account. Fine, but it's a corp account gaining a workshop role.
- The demo program (`demo/pulumi-ts`) creates SQS, RDS and CloudWatch there.

Options, roughly in order of preference:

1. **A separate personal AWS account** for the workshop. Cleanest — you control
   what's visible, and the read-only story is unambiguous. Costs the most setup:
   new account, new OIDC trust, new ESC environment.
2. **Stay in 616138583583, but only ever through the new read-only environment**,
   never `shared/cloud-creds`. Cheapest. Still means corporate bucket names are
   one `aws s3 ls` away.
3. Ask internally whether there's a sanctioned demo account already.

Needs deciding before the Thursday build block, because it determines where
both programs get deployed.

## Together, Thursday Aug 27 build block

- [ ] `pulumi up` both programs (into whichever account the decision above picks) — `demo/pulumi-ts` and `demo/esc-readonly-role`.
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
