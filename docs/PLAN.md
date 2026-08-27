# Extending Pulumi Neo: MCP Servers and Cloud CLIs — workshop (US Sep 8 + EU Sep 30)

> **Moved 2026-08-27** from `~/para/projects/neo-mcp-workshop/` into the workshop
> repo, so the planning record sits beside the deck, the demos and `TODO.md`.
> Earlier history: `git log --follow -- projects/neo-mcp-workshop/PLAN.md` in `~/para`.
>
> ⚠️ Sections below dated **2026-08-25** predate the Aug 27 work (Context API
> slides, demo badges, the 60-minute event-page fix, `docs/since-launch.md`) and
> have not been reconciled. `TODO.md` is the current list.


**What:** Live workshop, 2 sessions. US: **Tue Sep 8, 12:00–1:00 PM ET** (9:00 PT, **60 min** — settled 2026-08-25 off BigMarker's `Duration 1 hour`; confirmed by Adam, chat). Adam presents. EU: **Wed Sep 30, 10:00 AM CEST** (60 min) — Engin presents.
**Rock:** `periodic/rocks.md` → `neo-mcp-us-2026`. Prep block: Thu Aug 27 1:00–2:30.
**Origin:** Engin's title-only line in #workshops, Jul 28 — no brief existed before this file.

## Content decision (the open question)

Researched 2026-08-10 (3 parallel sweeps: Slack, Notion, GitHub — findings logged in `retro/2026-08-10.md`):

- **Base = the May 20, 2026 integrations launch.** Neo *consuming* MCP servers (Atlassian, Datadog, Honeycomb, Linear, PagerDuty, Supabase) + CLI integrations (aws, gcloud, az, kubectl), ESC-backed creds. The Notion row's draft abstract says this explicitly; live docs still list exactly this set; no September Neo launch brief exists anywhere. "New" in the title is marketing framing.
- **BUT Engin wants Custom Agents folded in if it ships in time** — and Mark Huber's answer was "goal is september, but that's a pretty fluid goal." Still pre-launch engineering as of Aug 10. ⛔ **Do not put Custom Agents in public copy until Mark confirms a usable-by-Sep-8 date.** Natural out: Engin's own Sep 23 workshop ("AI Agents for IT Ops: Custom Agent on AKS") is the Custom Agents session.
- **Shipped-since-May extensions worth folding into the copy** (safe, real):
  - Per-automation CLI integration selection (pulumi-service, merged 2026-08-06) — CLI integrations in scheduled Neo Automations, not just interactive tasks.
  - Neo in your editor via ACP (docs merged 2026-07-29) — Zed / JetBrains / VS Code / Cursor, inheriting local authenticated CLIs.
- Smaller Engin thread: add **partner MCPs (dash0)** to the catalog as a BD gesture (Michele approved the outreach).

## Reference material

**May release (shipped — the workshop's base), public:**
- Launch blog (May 20): https://www.pulumi.com/blog/neo-integrations/ — "Neo Integrations: MCP Servers and Cloud CLIs" (alias `/blog/neo-integration-catalog/`) · local: `~/sandbox/docs/content/blog/neo-integrations/index.md`
- Docs: https://www.pulumi.com/docs/ai/neo/integrations/mcp/ (the six MCP integrations) · https://www.pulumi.com/docs/ai/neo/integrations/cli/ (aws/gcloud/az/kubectl, ESC-backed)
- Shipped-since-May, public: Neo in your editor via ACP — `content/docs/ai/neo/editors/` (merged Jul 29) · per-automation CLI integration selection (pulumi-service, merged Aug 6 — changelog/docs trail thin, confirm surface before demoing)

**May release, internal (Notion):**
- Integration Catalog: https://app.notion.com/p/305fdbdf1cce80028270eb28813a2f30
- Neo in the CLI V2: https://app.notion.com/p/334fdbdf1cce8008a070cad8be42af86
- Neo <> MCPs: https://app.notion.com/p/31bfdbdf1cce80d18a26ed2a5929834d
- Customer demand: Neo consumable from external agents/IDEs (Cursor/Copilot — demand tracking, no ship date): https://app.notion.com/p/375fdbdf1cce81c5bdeacc032f9f787d

**Custom Agents (the possible "new" part — all internal, pre-launch):**
- Custom Agents — POC1 + Extensions (Eng Design) *(updated Aug 10)*: https://app.notion.com/p/3b2fdbdf1cce81bcb443c1192fc8ef79
- "Introducing Pulumi Agents" (launch-messaging draft, *updated Aug 10*): https://app.notion.com/p/3adfdbdf1cce81ac93daf5aa44278ab4
- Pulumi Agents (product page, Aug 6): https://app.notion.com/p/304fdbdf1cce804fa8bdca3d516d123d
- Agents as Team Members (Jul 27): https://app.notion.com/p/380fdbdf1cce80139938e2c06818c821
- Neo and AI: Near-Term Direction (Summer FY26) (May 28 — puts Custom Agents on the roadmap): https://app.notion.com/p/36bfdbdf1cce80a7b567ff17e55c61e5
- Pulumi Neo master gdoc (Feb — "Agent integration (exploratory): external agents invoke Neo"): https://docs.google.com/document/d/13CZNWoug0PuNznKvOUowsaW6_oxTdGnav90wTNPBW9w

## Key Slack messages

- **Engin ↔ Mark Huber DM, Jul 30 — the Custom Agents ask + "fluid September" answer** (links the workshop schedule): https://pulumi.slack.com/archives/C0BLW2004RK/p1785434655199769
- Mark drafting the **September "agent teams" launch** (incident-triggers demo — mirrors this workshop's incident walkthrough), #marketing Jul 28: https://pulumi.slack.com/archives/C7XHM1GNT/p1785277733121479
- Mark on Custom Agents being actively designed, #pulumi-neo Aug 6: https://pulumi.slack.com/archives/C093AS5BHJ7/p1786034779507859
- Custom Agents still pre-launch: POC dump #team-ai Aug 10 https://pulumi.slack.com/archives/C050F6LUDPX/p1786380688644539 · auth/roles UX in flight, Aug 5 https://pulumi.slack.com/archives/C050F6LUDPX/p1785955229237329
- **Workshop origin line**, Engin in #workshops Jul 28 ("Neo Integration workshops … (2x) @Adam"): https://pulumi.slack.com/archives/CPD83QEQ1/p1785245956687319
- Adam's date-move note (#workshops, Aug 10, Sep 9→8 off the KCDC flight): https://pulumi.slack.com/archives/CPD83QEQ1/p1786371870138849
- Partner-MCP / dash0 gesture, group DM Jul 30: https://pulumi.slack.com/archives/C09RUBPSJ6T/p1785435574146809
- MCP integrations live-and-being-bugfixed (cold-start issue), Simon #pulumi-neo Aug 6: https://pulumi.slack.com/archives/C093AS5BHJ7/p1786036626408029

## Artifacts

- **Event pages PR (DRAFT until content confirmed):** https://github.com/pulumi/docs/pull/20800 — `content/events/extending-pulumi-neo-mcp-cloud-cli{,-eu}/index.md`, branch `adam/extending-pulumi-neo-mcp-events`. Form ids blank.
- **Ops ticket (Calon):** https://github.com/pulumi/marketing/issues/1826 — both sessions, abstract marked provisional.
- **Notion schedule rows:** US https://app.notion.com/p/3abfdbdf1cce816b8648c09d753961b1 · EU https://app.notion.com/p/3abfdbdf1cce81b0a818c6432a7ee1c3 (both carry the draft May-content abstract).
- **Meta images (Aug 10):** rendered via `scripts/meta-images/render-event-cards.mjs` for both slugs (five sizes each, committed on the PR branch, `meta_image`/`meta_image_square` set).
- **Luma events (Aug 10, PRIVATE until rollout):** US `evt-KXZcDtQw9eB8DTF` https://luma.com/pulumi-bqtq · EU `evt-n1L5xB2GFE6MXgC` https://luma.com/pulumi-3ity — created via `luma` CLI with covers; flip with `luma update <id> --set visibility=public --post` at rollout.
- Source copy: `~/sandbox/docs/content/blog/neo-integrations/index.md` (May launch post) · docs at `content/docs/ai/neo/integrations/{mcp,cli}/`.

## Integration access (researched 2026-08-24, Slack + docs repo)

**AWS CLI — no blocker.** ESC Login Provider Setup wizard (Environments → Create environment → AWS) handles the OIDC trust and writes the environment. Scope read-only.

**PagerDuty — reuse Engin's work.** Three finds, same direction:
- ⭐ **The Dec workshop is findable and recorded: "Day-2 Autonomous Infrastructure Management", Tue Dec 9 2025, 60 min — and Adam co-presented it.**
  - Event page: https://www.pulumi.com/events/day-2-autonomous-infrastructure-management/ · local `~/sandbox/docs/content/events/day-2-autonomous-infrastructure-management/index.md`
  - **Recording: https://www.youtube.com/watch?v=nx6oJvX2JNE** (embed `nx6oJvX2JNE`)
  - Presenters: Engin Diri + Adam. Topics tagged `Policy as Code`, `Pulumi Neo`, `DevSecOps`, `PagerDuty`; cloud AWS. Billed learning outcomes: monitoring and remediation workflows · proactive optimization and cost management · **security incident response automation**.
  - ⭐ **Demo repo (linked from the YouTube description): https://github.com/dirien/pulumi-ai-workshop-base** — `WORKSHOP_SCENARIOS.md` is the walkthrough, `index.ts` the stack, `functions/packages/security/pagerduty-webhook/` the glue service.
  - **Its architecture (detection → PagerDuty → Neo):** Falco (runtime), Trivy (CVE), Kyverno (policy), Prometheus (metrics) on a DigitalOcean K8s cluster → Falcosidekick / Alertmanager → **PagerDuty** → DO App Service webhook → **Pulumi Neo API** creates a task.
  - **Four trigger-on-demand scenarios**, each with copy-paste commands + cleanup: (1) shell spawned in a pod, caught by Falco — `kubectl exec` into a test pod; (2) CVE detection via Trivy — `kubectl scale deployment vulnerable-nginx --replicas=1`; (3) policy violation via Kyverno — `kubectl scale deployment privileged-pod --replicas=1`; (4) resource exhaustion via Prometheus — a stress pod at >90% of its memory limit. **Scenarios 2 and 3 are deliberately shaped for Neo remediation**: the offending deployment lives in `index.ts` at `replicas: 0`, so Neo's fix is a PR against the Pulumi program.
  - 🔑 **The direction nuance — do not overclaim on stage.** Engin's "glue coding" was the **inbound** leg: a webhook service that receives `incident.trigger` from PagerDuty and calls the Neo API to *create* a task, injecting repo / org / project / stack / ESC env / cluster as context. **The new MCP integration is the outbound leg** — Neo *reading* PagerDuty during a task it is already running. So MCP does **not** replace his webhook; auto-triggering a task from an incident still needs that glue. The honest framing: *"the reading half is now a toggle; the triggering half is still yours to wire."* ⛔ Do not say the integration replaces what he built.
- Engin built this exact workshop in **Dec 2025** — #pulumi-neo Dec 9 ("PagerDuty is creating Neo Task for reported incidents") and Adam's Dec 18 recap (PagerDuty assigns issue → Neo raises PR → links it back → marks resolved). He notes it needed **glue coding** then. ⭐ That's a workshop beat, not just background: *here's what I hand-wired in December, here's the toggle now.* Same beat available for Linear (Mark Huber, Dec 18, custom instructions + ESC to reach Linear tickets before MCP support existed).
- Engin's **Jul 20 2026 blog** `/blog/incident-response-as-code-pagerduty-pulumi/` (local: `~/sandbox/docs/content/blog/incident-response-as-code-pagerduty-pulumi/index.md`) ships a TypeScript program provisioning the **whole** PagerDuty side (team, weekly rotation, 2-level escalation policy, service + CloudWatch integration) plus DLQ → alarm → SNS wiring. **Seeds a fresh trial's full config with one `pulumi up`** — biggest time-saver available.
- Its prerequisites say "a free trial works fine." ⚠️ That's the blog's prescription; **not confirmed** to be what the Dec workshop actually ran on — ask Engin.
- Pulumi's real PagerDuty (`pulumi.pagerduty.com`, "Cloud AI" rota) exists — **do not demo against production on-call.**

**Datadog — no internal account found.** Every Slack hit was customer resources in the warehouse, the Pulumi Datadog *provider*, or GTM bot noise. Trial only, and Datadog's is **14 days** → would need starting ~Aug 25–26 to survive Sep 8, and the Aug 27 build too. **Keep it off the critical path** (see demo cases — the diagnosis is config-based, so Datadog isn't needed).

**Honeycomb — cheapest real access if wanted.** Pulumi runs on it internally (Simon/Davide dashboards + alerts in #pulumi-neo). Warm partner path: jkiser ↔ Marcus (alliances at Honeycomb, Jul 2025); Jan 2026 joint Honeycomb+AWS webinar; `dirien/kubecon-na-honeycomb-pulumi-aws-workshop`. Cost of swapping it in for Datadog: it's traces, not metrics — the "growth curve" beat would need reshaping.

**Linear — trivial.** Personal API key, no service account.

## Build progress 2026-08-25 (unattended session)

Repo `~/sandbox/extending-pulumi-neo/` now carries the whole demo, authored but **not deployed** — no `pulumi up`, no trial started, no remote pushed. Commits `1ffd215`, `b52f2d3`, `231a6f9`.

- ✅ **`demo/pulumi-ts/`** — the incident chain (payment queue → DLQ → CloudWatch alarm → SNS → PagerDuty, plus the PagerDuty team/schedule/escalation/service/integration). **Typechecks clean.** Shape borrowed from Engin's July post + `dirien/pulumi-pagerduty-fargate-demo`, minus the Fargate worker (a 15-min beat can't carry a container build).
- ✅ **`demo/FINDINGS.md`** — the three deliberate faults Neo is meant to find, all single-look/config-shaped: `maxReceiveCount: 1` · an alarm with no `alarmActions` · `maxAllocatedStorage == allocatedStorage`.
- ✅ **`demo/{trigger-incident,cleanup,prewarm}.sh`** — cause a page / reset between rehearsals / read-only pre-flight.
- ✅ **`demo/esc-readonly-role/`** — Pulumi program for the narrow `ReadOnlyAccess` role + Pulumi OIDC trust, with the ESC environment YAML in a comment. Typechecks clean. ⇒ Thursday is `pulumi up`, not authoring.
- ✅ **`.devcontainer/`** — node/aws/gh/pulumi/claude-code, installs all three npm projects, port 3030 for the deck. Auth stays manual by design.
- ✅ **Slides 17–18 are now real mermaid diagrams** (Engin's detection→PagerDuty→webhook→Neo chain, and the reading-half/triggering-half split), replacing the text columns. Rendered and visually checked.

### 🔴 Two findings that change the plan

1. **PagerDuty's trial is 14 days** (confirmed on pagerduty.com/sign-up). ⇒ **Start it on or after Thu Aug 27** — Aug 27 + 14 = Sep 10, putting the workshop on day 12 of 14. ⛔ Starting it today (Aug 25) expires it *on* Sep 8. This is now a dated action, not a vague one.
2. **The page is not instant, and this nearly ate the beat.** Engin's measured run took **3m45s** from poison message to alarm, 3m49s to page — longer than the entire Linear beat. Mitigated two ways: the program uses `maxReceiveCount: 1` + a 5s visibility timeout (leaving just the alarm's 60s evaluation period), and `PRESENTER.md` now instructs **triggering during beat 2**, so the incident is already open when beat 3 starts. ⭐ Neatly, the setting that makes it fast *is* fault #1 — the bug Neo diagnoses is the property that makes the demo presentable, and the fix lands as a PR rather than being applied live.

### Still needs Adam
`pulumi up` on both programs · start the PagerDuty trial (≥ Aug 27, `pulumi-bot` user) · connect the three integrations in `adamgordonbell-org` · run the credential-precedence test · pick a remote (`dirien/*` vs `adamgordonbell/*`, which also unblocks the repo QR) · decide beat 5 · settle the strip-vs-heading naming mismatch (`connect`/`incident`/`beyond` vs *Ask*/*Delegate*/*Stop initiating*).

## Session concept: "Ten More Things," live (Adam, 2026-08-25)

**The thrust of the session is the `neo-things` series performed on stage** — Adam's own May 19 2026 post [*Ten More Things You Can Do With Pulumi Neo*](https://www.pulumi.com/blog/10-more-things-you-can-do-with-neo/) (`~/sandbox/docs/content/blog/10-more-things-you-can-do-with-neo/index.md`, author `adam-gordon-bell`, `series: neo-things`), narrowed to the items that turn on an integration. *(The 2025 original, `10-things-you-can-do-with-neo`, is Meagan Cojocar's — same series, different author.)*

⭐ **The post's arc beats the five-beat structure I scaffolded first.** Items 1–7 are things you *ask for*; items 8–10 run *without you*. Adam's own LinkedIn blurb states it: *"platform engineers used to keep things in their heads, then they delegated them to Neo, then those tasks started running on a schedule without anyone initiating them."* ⇒ session spine = **ask → delegate → stop initiating**, and integrations are what make each step possible.

**Item → beat mapping:** #4 Linear ticket = opener · #3 PagerDuty incident = the spine · #5 IAM narrowing = the scope beat (a demo *about* least privilege, delivered by the tool people fear has too much) · #8/9/10 drift, Lambda, CIS = the closer, pick one · #2 slow-API diagnosis = 🟡 only if Honeycomb lands (no Datadog account) · #1/6/7 = ❌ not integration-driven, cut.

⚠️ **Two accuracy traps in reusing the post's copy:** item 3 is written as **Slack**-invoked, not CLI — reframe, don't quote. And item 2's *"last 7 days of metrics"* is trend-shaped, so it hits the same fresh-account wall as the launch blog's marquee beat.

### ⭐ The demo assets already exist — this closes the R2 fallback gap

Shot by Adam in May, sitting in the blog directory: **`neo-linear.mp4`** (15M — **Neo running locally in the Pulumi CLI**, Linear issue → PR; already the exact delivery surface Adam picked) · `honey-comb.mp4` (toggling an integration on) · `iam-narrow.mp4` · `neo-schedule-setup.mp4` · `neo-cis-pr.mp4` · `deploy-to-aws2.mp4` · `neo-integration-catalog.png` (the six integrations w/ Authorize buttons) · `neo-drift-pr.png` · `neo-migration-prs.png`.

⇒ **Every beat has a recording, in Adam's voice, on assets he owns.** ⛔ Never re-render the R2 finding *"PRESENTER.md wants a recording per beat and none exists"* as a risk on THIS workshop — it was true for `devops-ai-skills-r2-2026` and is false here. `PRESENTER.md`'s failure plan now routes each beat to its clip.

**Backing repos, both local:** `~/sandbox/iam-narrow-demo` (Python, item 5) · `~/sandbox/neo-examples` (EKS, `ca-central-1`, ESC `oidc/oidc`, policy pack, `docs/aws-oidc-setup.md` + `docs/script.md` — the latter probably the shooting script for the videos).

## Workshop repo (scaffolded 2026-08-25)

**`~/sandbox/extending-pulumi-neo/`** — git init'd, first commit `74e76f4`, no remote yet. Modelled on `~/sandbox/getting-started-with-devops-ai-skills` (Adam's own R2 repo), minus `chapters/` and `.devcontainer/` — both dead once the session went demo-only.

| Path | State |
|---|---|
| `OUTLINE.md` | ✅ the argument + all five beats, with the cut order (beat 4 first, then beat 1 → screenshot; **beat 2 never cut**) |
| `PRESENTER.md` | ✅ 60-min clock w/ wall times, pre-flight checklist, failure plan, "things not to say" |
| `README.md` | ✅ public-facing; credits Engin's Dec 9 workshop + repo, carries the inbound/outbound distinction |
| `docs/credentials.md` | ✅ demo-org setup, the `AdministratorAccess` finding, the precedence test |
| `slides/slides.md` | 🟡 **starter deck, 20 slides — builds clean** (`npm run build` ✓). Theme `@pulumi/slidev-theme`, `StageMap` re-staged to why·connect·incident·scope·beyond. Cover/bio/housekeeping/agenda + section dividers + one content slide per beat. **Needs the real demo screenshots and the QR codes.** |
| `demo/` | 🔴 README only — the program, `trigger-incident.sh`, `cleanup.sh`, `prewarm.sh` are Thursday's build |

Assets carried over from the R2 repo: Pulumi logos (4 variants), Inter + Monaspace fonts, Adam + Engin headshots, `style.css`, `lines.svg`, the slides `CLAUDE.md` (+ `AGENTS.md` symlink).

## Demo org and credentials (confirmed live 2026-08-25)

**Org: `adamgordonbell-org`** (Adam, chat). `pulumi whoami -v` → orgs `adamgordonbell`, `adamgordonbell-org`, `lumitorch`. ESC environments already present in it: `shared/cloud-creds`, `oidc/oidc` (Azure), `superintelligence-nebula/aws-creds`, plus azure-dev / payments / payment-service / todo-demo / strava-slack-bot / default.

- ✅ **OIDC is already set up — Adam's assumption confirmed.** `shared/cloud-creds` is exactly the shape the `aws` CLI integration wants: `fn::open::aws-login` with `oidc: {duration: 1h, roleArn: arn:aws:iam::616138583583:role/pulumi-environments-oidc, sessionName: pulumi-esc}`, emitting `AWS_ACCESS_KEY_ID` / `AWS_SECRET_ACCESS_KEY` / `AWS_SESSION_TOKEN` — the exact three variables the CLI-integration docs table requires. Region `ca-central-1`.
- 🔴 **DO NOT point the workshop's `aws` integration at `shared/cloud-creds`.** Verified this run via `pulumi env run adamgordonbell-org/shared/cloud-creds -- aws iam list-attached-role-policies --role-name pulumi-environments-oidc`: the role carries **`AdministratorAccess`** (single attached policy, no inline policies; caller `arn:aws:sts::616138583583:assumed-role/pulumi-environments-oidc/pulumi-esc`). Two consequences, both fatal to the session:
  1. **The narration becomes false.** The credential beat sells *"scoped to exactly the permissions you choose… prefer a read-only role"* while handing Neo admin over the whole account — in a workshop that is substantially *about* scoping. This is the question the chat asks.
  2. **It makes the precedence test undecidable** (see the Thursday check above): an admin ESC role can do everything the laptop profile can, so there is no observable difference between the two resolutions.
- ⇒ **Build a deliberately narrow env for the workshop**, e.g. `adamgordonbell-org/neo-workshop/aws-readonly`: same OIDC trust, new IAM role with `ReadOnlyAccess`. Makes the story true *and* makes the precedence test decisive — ask Neo for a mutation; the ESC role refuses, the laptop admin succeeds, and that single result names which credentials are in play. Provisioning that role with a small Pulumi program is on-brand for the demo repo.
- ⚠️ **Region:** `shared/cloud-creds` is `ca-central-1`; Engin's PagerDuty/CloudWatch program must agree on region or the alarm and Neo's `aws` queries look at different places.
- ⚠️ PagerDuty MCP tokens are **user-scoped** — docs advise a dedicated `pulumi-bot` user rather than Adam's own.

## Demo cases

**Constraint that picks these: trial accounts have no history.** They hold whatever was provisioned five minutes ago. So every case turns on *configuration* or *live state* (provisionable, CLI-readable) — never *trend*. ⛔ This kills the launch blog's marquee beat: "storage growing 5 GB/day over 30 days" needs 30 days of Datadog history that cannot be faked in a trial.

1. **Incident → diagnose → PR → resolve** (PagerDuty + aws CLI) — *the spine.* **Prior art to credit and build on: Engin's Dec 9 2025 "Day-2 Autonomous Infrastructure Management" (recording: https://www.youtube.com/watch?v=nx6oJvX2JNE) — watch it before Thursday; Adam co-presented, so the framing is already partly his.** Engin's blog program provisions DLQ → CloudWatch alarm → SNS → PagerDuty, so **a real page can be caused on demand**: drop a message in the DLQ, get a genuine incident with a real timestamp. Live, reproducible, re-runnable between rehearsal and delivery. Make the finding **config-shaped**: no redrive policy, `maxReceiveCount` 1, `AllocatedStorage == MaxAllocatedStorage`, alarm with no action — all readable in one `aws` call, fixable in the program, provable via `pulumi preview`. Ends in a reviewable PR + resolution posted back to PagerDuty.
2. **Ticket → infra change → PR** (Linear) — *the opener.* 30 seconds of setup. Neo picks up "PUL-123: staging bucket with versioning", writes the change, opens the PR, comments back on the ticket. Short, and lands the core idea (Neo reads your tools, not your paste buffer) before spending attention on the incident walkthrough.
3. **What's running that no stack knows about** (aws CLI only, zero external accounts) — *the safety net.* Buckets without versioning; resources in the account but in no stack. The CLI integration's real distinction from MCP: live cloud state. Survives an expired trial, an unreachable vendor MCP server, or a key rotating that morning. Also the honest answer for the slice of the room using none of the six services.
4. **Scoping and blast radius** (per-task toggles) — one click, no setup. Start a task with the issue tracker toggled off. Then the credential story: CLI creds in ESC, never stored by Pulumi Cloud, materialized at task time via `pulumi env run` and torn down; MCP creds encrypted per-org, never reach the model. Show `staging-aws` vs `production-aws`. Answering this live beats another feature.
5. **Beyond the interactive task** — *the closer.* Pick **one**: per-automation CLI integration selection (same integration, scheduled Automation, nobody at the keyboard) OR Neo in your editor via ACP inheriting local authenticated CLIs. ⚠️ Automations docs trail is thin — confirm the surface Thursday before committing.

**Running order (60 min — LOCKED, Adam 2026-08-25). Demo-only: Adam drives, attendees watch.** Linear opener ~7 → incident walkthrough ~22 → scoping + credentials ~10 → beyond-the-interactive-task closer ~8 → Q&A ~10.

⛔ **The attendee hands-on block is CUT and does not come back.** It died twice over: 60 min has no room for it, and MCP integrations are an org-admin toggle attendees can't perform on their own org mid-session. ⇒ the repo is deck + `PRESENTER.md` + a demo program attendees clone afterward — **no `chapters/` follow-along.**

**Delivery surface: `pulumi neo` from the terminal** (Adam, 2026-08-25). Confirmed against `content/docs/ai/neo/pulumi-cli/_index.md`: *"Integrations carry over from Pulumi Cloud… work the same way from the terminal."* ⇒ **ESC-backed CLI integrations work from the CLI** — the org connects `aws` to an ESC environment, and Neo invokes `pulumi env run <ref> -- aws …` as the acting user regardless of surface. ⛔ Do not repeat the earlier claim that driving from the CLI skips the ESC story; it does not. Bonus callback: the [Neo handoff skill](https://github.com/pulumi/agent-skills/tree/main/delegation) lets Claude Code start a `pulumi neo` task — ties straight back to the Aug 12 DevOps AI Skills workshop.

**At 60 min the hands-on block dies** (and the Linear opener with it) — it becomes demo-only. ⚠️ **This is why the BigMarker 60-vs-90 conflict is a content decision, not a scheduling detail:** it decides whether attendees configure anything themselves.

## Next actions

- [ ] **Ask Engin (Slack, stacks with chat-co-pilot/Robin/booth-call batch):** is Custom Agents in or out for Sep 8 given Mark's "fluid" September? If out → ship the page on the integrations story; Custom Agents = its own later session.
- [x] ~~Retune PR #20800 description~~ — DONE Aug 10, Adam approved: use-case framing (no fixed session format), "we" voice, Automations + editors/ACP folded in, YAML map bug fixed. Remaining on the answer: un-draft + sync abstract to marketing#1826.
- [x] ~~**After Jeff's docs#20794 merges**: restructure #20800 to the single-page sessions format~~ — ✅ **DONE Aug 17 and MERGED Aug 19 12:18Z.** `pulumi/docs#20800` is `state MERGED` (Adam merged it himself, past dirien's never-submitted review) and **`pulumi.com/events/extending-pulumi-neo-mcp-cloud-cli/` returns 200, live**; the `-eu` URL 404s correctly because both sessions now live on one page. ⛔ Never re-render "day 9 / nudge dirien." *(Original text: restructure #20800 to the single-page sessions format — one bundle, one set of meta images (re-render), US Sep 8 Adam + EU Sep 30 Engin as sessions. Check whether form/campaign ids become per-session.
- [x] ~~Calon returns HubSpot form + SF campaign ids on #1826 → fill frontmatter → merge → **rollout**~~ — ✅ **DONE**: ids wired Aug 17, both Luma events flipped public + covers/descriptions fixed Aug 17, page merged and live Aug 19. 🆕 ✅ **And the BigMarker room now EXISTS** — presenter notification Aug 19 12:01 PM, conference `f4d6709a7b01`, so `marketing#1826` is at **4 of 11** and Luma's `meeting_url` finally has a target. ✅ **Duration reconciled 2026-08-25 to 60 min** (rock, Index, hold `ksst97jbl2v51i28j7507sckus` and this plan all corrected; ledger line same date). ⚠️ **Check the live event page + Luma copy still don't say 90.** Residual is Calon's: social organic/paid, targeted emails, /resources link, Pulumi Cloud org, after-event emails. *(Original: flip both Luma events public (`luma update evt-KXZcDtQw9eB8DTF --set visibility=public --post`, same for `evt-n1L5xB2GFE6MXgC`), point them at the live reg page.
- [ ] Flag the Tuesday slot to Jacob Kramer's promo tracker (breaks the Wednesday pattern).
- [ ] Build the actual workshop (prep block Thu Aug 27): decide live demo vs pre-baked for the incident walkthrough; needs a demo org with the six MCP integrations + a scoped CLI integration configured.
- [ ] **Watch the Dec 9 recording** (https://www.youtube.com/watch?v=nx6oJvX2JNE) before the Aug 27 build block — it is the closest prior art and Adam is in it.
- [x] ~~**Ask Engin**~~ **Dropped (Adam, 2026-08-27).** Both questions resolved without him: a PagerDuty trial covers the demo (start on/after Aug 27, 14-day term puts Sep 8 on day 12), and Custom Agents remain unannounced — no `#product-updates` post in 120 days and no docs page, so the ⛔ guard in `PRESENTER.md` stands. Draft `engin-ask.md` deleted. He still presents the **Sep 30 EMEA repeat**, so he needs the deck; nothing else is blocked on him.
- [ ] Confirm the per-automation CLI integration surface before demoing it (Thursday build).
- [ ] 🔑 **Resolve credential precedence for `pulumi neo` before writing the credential beat (Thursday build).** When running locally, does the `aws` CLI resolve to the org's ESC-backed CLI integration, or to the AWS creds already on the laptop? **The docs do not say.** `pulumi-cli/_index.md` only ever states the local direction (*"inherits your setup: the CLIs you've authenticated"*, and its `meta_desc` reads *"access to your local project, credentials, and stacks"*) while the same page says integrations *"work the same way from the terminal"* — no precedence rule anywhere, and `editors/_index.md` repeats the ambiguity. ⚠️ **This is the failure mode where nothing breaks visibly:** if local creds silently win, the demo still works while the narration ("scoped, read-only, short-lived, ESC-owned, Pulumi Cloud never stores it") is false on stage. **Test:** point the `aws` integration at a deliberately read-only ESC env, then ask Neo for something the laptop profile can do and the ESC role cannot — see which way it resolves. ⇒ Likely also a `pulumi/docs` issue regardless of the answer.
