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
- [ ] **Start the PagerDuty trial — on or after Thu Aug 27.** Trial is 14 days.
      Aug 27 + 14 = Sep 10, so Sep 8 lands on day 12. Starting it any earlier
      expires it before or on the workshop. Sign up as the `pulumi-bot` user.
- [ ] **Connect the integrations** in `adamgordonbell-org` (Neo Settings →
      Integrations). Org-admin only. Two sections, connected separately:
      - **MCP tools:** PagerDuty, Linear, and one of Datadog/Honeycomb.
      - **CLI tools:** AWS → point it at the **new read-only** environment.
      ⛔ **Point the AWS CLI integration at the new read-only environment, not
      `shared/cloud-creds`.** The latter assumes `pulumi-environments-oidc`,
      which carries **AdministratorAccess** (verified) — connecting it would
      make slide 24's read-only claim false and the precedence test undecidable.
- [x] ~~Confirm the org login slug.~~ It's `adamgordonbell-org` (confirmed via
      `pulumi whoami -v`). Slides and `pulumi env run` examples updated.
- [ ] **Pick the repo remote** — `adamgordonbell/*` or under `dirien/*`.
      Blocks the repo QR code on the closing slide.
- [x] ~~Check the live event page duration.~~ pulumi.com said **90 min** on the
      Americas tab (EMEA already said 60). Fixed in
      [pulumi/docs#21175](https://github.com/pulumi/docs/pull/21175) — merge it and
      the page is right. There is no Luma; registration is a gated HubSpot form on
      pulumi.com, delivery is BigMarker `f4d6709a7b01`.

## AWS account — settled

**It's the work demo account.** Account `616138583583`, the same one your local
`work-demo` SSO profile points at (`sso_account_id = 616138583583`,
`AdministratorAccess`, default region `ca-central-1`). It's a member of the
Pulumi AWS org, which is just what a corporate demo account looks like.

**ESC → AWS OIDC verified working Aug 25.** Driven by `shared/cloud-creds`,
`pulumi up` created an S3 bucket in 5s and `pulumi destroy` removed it. Stack
config that worked:

```yaml
environment:
  - shared/cloud-creds
config:
  aws:region: us-west-2
```

Two things still follow from this, both small:

- **The read-only environment is still worth building** — not for safety, but
  because slide 24 says out loud that everything ran against a read-only role.
  If the AWS CLI integration points at `shared/cloud-creds` (admin), that line
  is false on stage. This is a presentation-honesty requirement now, not a
  security one.
- **It makes the precedence test clean.** Your laptop has admin on
  `616138583583` via `work-demo`; the new ESC environment will have read-only
  on the *same* account. Same account, different permissions, so whichever one
  `pulumi neo` picks locally is unambiguous — if a write succeeds, laptop creds
  won; if it's denied, ESC won.

## Together, Thursday Aug 27 build block

- [x] ~~Upgrade the Pulumi CLI.~~ v3.237.0 → **v3.259.0** (Aug 27). Clears both
      bars: `pulumi api` needs 3.243.0+, `pulumi neo acp` needs 3.254.0+.
      Homebrew needed `brew trust pulumi/tap` first (official tap, already the
      install source).
- [ ] **Time the Context API index lag.** After `create-unmanaged.sh`, run
      `demo/context-api/query.sh unmanaged-security-groups.json` on a clock and
      find out how long the scan takes to notice the new group. The demo-2 beat
      depends on the answer: index-behind-live if slow, "here's when it
      noticed" if fast. Don't script the punchline until this is measured.
- [ ] `pulumi up` both programs (into `616138583583`) — `demo/pulumi-ts` and `demo/esc-readonly-role`.
      Neither has been deployed; they only typecheck.
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
