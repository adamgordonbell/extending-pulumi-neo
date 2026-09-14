# Demo setup: accounts and credentials

> What a presenter needs to stand up the demo org and scope credentials for it.

**Settled Aug 25–27 2026:** the account is `616138583583` (Adam's `work-demo` SSO
profile), and ESC → AWS OIDC is verified end to end. What follows is why the AWS CLI
integration still needs its own narrow environment, and the one question left open.

Notes for setting up the demo org. Nothing here is presented as-is.

## Org

`adamgordonbell-org`. Existing ESC environments include `shared/cloud-creds` (AWS OIDC,
`ca-central-1`), `oidc/oidc` (Azure OIDC), and `superintelligence-nebula/aws-creds`
(a second AWS account, `us-west-2`).

## 🔴 Do not use `shared/cloud-creds`

It is the right *shape* — `fn::open::aws-login` with OIDC, 1h sessions, emitting the three
variables the `aws` integration expects — but its role
`arn:aws:iam::616138583583:role/pulumi-environments-oidc` carries **`AdministratorAccess`**
(verified 2026-08-25, single attached policy, no inline policies).

That breaks two things at once:

1. **Beat 3 becomes false.** The claim is *"scoped to exactly the permissions you choose."* Admin over the whole account is the opposite, in the beat that is specifically about scoping.
2. **The precedence test below becomes undecidable** — an admin ESC role can do everything the laptop profile can, so the two are indistinguishable.

## Instead: a narrow environment

`adamgordonbell-org/neo-workshop/aws-readonly` — same OIDC trust, a new IAM role with
`ReadOnlyAccess`. Provisioning that role with a small Pulumi program is on-brand for this
repo.

**Neo does not need write access.** The remediation in beat 2 is a pull request, not a
mutation. Read-only is both sufficient and the better story.

## Open question: credential precedence

When running `pulumi neo` locally, does the `aws` CLI resolve to the **org's ESC-backed
integration** or to the **AWS credentials already on the laptop**? The docs do not say.

- `docs/ai/neo/pulumi-cli/`: *"Neo inherits your setup: the CLIs you've authenticated…"*, and its meta description says *"access to your local project, credentials, and stacks."*
- Same page: *"Integrations carry over from Pulumi Cloud… work the same way from the terminal."*

No precedence rule appears anywhere; `docs/ai/neo/editors/` repeats the same ambiguity.

⚠️ **This is the failure mode where nothing breaks visibly.** If local credentials silently
win, the demo still works while beat 3's narration is false.

**Test:** with the `aws` integration pointed at the read-only environment, ask Neo for
something mutating. The ESC role refuses; a laptop admin profile succeeds. That single
result names which credentials are in play.

Worth a `pulumi/docs` issue either way.

## Other

- **PagerDuty MCP tokens are user-scoped.** Use a dedicated `pulumi-bot` user, not a personal account.
- **Region agreement.** The ESC environment, the Pulumi program, and the CloudWatch alarm must all be in the same region, or the alarm and Neo's `aws` queries look at different places.
- ⛔ **Never demo against Pulumi's production PagerDuty** (`pulumi.pagerduty.com`) — that is the real "Cloud AI" on-call rota.
