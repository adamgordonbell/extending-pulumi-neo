---
theme: "@pulumi/slidev-theme"
title: "Extending Pulumi Neo: MCP Servers and Cloud CLIs"
info: |
  Extending Pulumi Neo: MCP Servers and Cloud CLIs.
  Adam Gordon Bell, Pulumi.

  Give Neo access to the systems your incidents actually live in.
transition: slide-left
mdc: true
canvasWidth: 1920
aspectRatio: 16/9
highlighter: shiki
lineNumbers: false
layout: cover
defaults:
  layout: default
---

<div class="absolute inset-0 flex flex-col justify-center items-start px-20">
  <h1 class="!text-[5.4rem] !leading-[1.04] !font-semibold !tracking-tight !mb-6 !max-w-[95%]">
    Extending Pulumi Neo
  </h1>
  <p class="!mt-2 !text-[2.1rem] text-[var(--p-fg-muted)] !m-0 !leading-relaxed">
    MCP servers and cloud CLIs — giving Neo the systems your incidents live in
  </p>
  <p class="!mt-6 !text-[1.8rem] text-[var(--p-fg-muted)] !m-0 !leading-relaxed">
    Adam Gordon Bell · Pulumi
  </p>
</div>

<!--
60 minutes. Two live demos, everything else slides.

Frame the hour in one sentence before moving: "Neo could always write Pulumi —
today is about giving it everything around the Pulumi."
-->

---

<div class="absolute inset-0 flex items-center px-24 gap-20">
  <div class="flex-shrink-0">
    <img src="/img/adam-gordon-bell.png" class="w-[28rem] rounded-2xl shadow-xl border-4" style="border-color: rgba(126,107,255,0.45)" alt="Adam Gordon Bell" />
  </div>
  <div class="flex-1">
    <h1 class="!text-[7rem] !leading-[1.02] !font-semibold !tracking-tight !mb-4 !text-[var(--p-primary)]">Adam Gordon Bell</h1>
    <p class="!text-[2.5rem] !leading-relaxed !m-0 opacity-90">
      Community Engineer at <strong class="!text-[var(--p-primary)]">Pulumi</strong>
    </p>
    <div class="!mt-8 flex items-center gap-8 !text-[1.5rem] opacity-70">
      <span class="flex items-center gap-2"><carbon-logo-x /> @adamgordonbell</span>
      <span class="flex items-center gap-2"><carbon-logo-linkedin /> adamgordonbell</span>
      <span class="flex items-center gap-2"><carbon-logo-github /> adamgordonbell</span>
    </div>
    <p class="!mt-10 !text-[1.75rem] !leading-relaxed opacity-70 !m-0">
      Host of the CoRecursive podcast.<br/>
      Telling the stories behind the code.
    </p>
  </div>
</div>

<!--
Short. Nobody came for the bio.
-->

---

# Housekeeping

<div class="zoom-content">

<ul class="!mt-8 !text-[1.6rem] !leading-relaxed space-y-5">
  <li>I'll <strong>present and demo</strong> — nothing to follow along with</li>
  <li>Ask questions <strong>any time</strong>; treat this as a conversation</li>
  <li>Slides and the repo go home with you — QR at the end</li>
  <li><strong>EMEA repeat Sep 30</strong> with Engin Diri, if a colleague missed this</li>
</ul>

</div>

<style scoped>
.zoom-content { zoom: 1.7; }
</style>

<!--
"Nothing to follow along with" is deliberate — it stops people from spending the
first ten minutes trying to get an org set up instead of listening.
-->

---
layout: two-cols
---

::header::

# Where we're going

::left::

<div class="!mt-6 !text-[1.5rem] !leading-relaxed space-y-8">

<div>
  <div class="!text-[1.9rem] !font-semibold !text-[var(--p-primary)]">Ask</div>
  <div class="opacity-80">You hand Neo a job. It reads the ticket, opens a PR.</div>
</div>

<div>
  <div class="!text-[1.9rem] !font-semibold !text-[var(--p-primary)]">Delegate</div>
  <div class="opacity-80">A page fires. Neo assembles the picture before you do.</div>
</div>

<div>
  <div class="!text-[1.9rem] !font-semibold !text-[var(--p-primary)]">Stop initiating</div>
  <div class="opacity-80">It runs on a schedule. You review what shows up.</div>
</div>

</div>

::right::

<div class="!mt-10 !text-[1.5rem] !leading-relaxed opacity-85">

That progression is the whole talk.

Each step needs Neo to reach **one more system it didn't have before** — a ticket
tracker, an alerting tool, a cloud account.

That reach is what integrations are.

</div>

<!--
This doubles as the agenda. Don't read the three words — say the story:
teams delegated things they used to keep in their heads, then stopped
initiating them at all.
-->

---
layout: section
---

# Why

## the gap between writing infrastructure and understanding it

<StageMap current="why" />

---

# Neo could always write Pulumi

<div class="zoom-content">

<p class="!mt-10 !text-[1.7rem] !leading-relaxed">
What it couldn't do was <strong>look at the systems the change actually lives in.</strong>
</p>

<p class="!mt-8 !text-[1.7rem] !leading-relaxed opacity-80">
The alert is in PagerDuty. The ticket is in Linear. The truth about what's running
is in the cloud account — not in the program.
</p>

<p class="!mt-8 !text-[1.7rem] !leading-relaxed">
So a human reads three consoles, and <em>then</em> writes the change.
</p>

</div>

<style scoped>
.zoom-content { zoom: 1.45; }
</style>

<!--
Don't oversell. The limit was context, not capability — that distinction is the
honest version and it's also more interesting.

If you want a concrete hook: p95 on /checkout goes from 200ms to 1.2s. The metric
is in one tool, the cause is in the cloud account, the fix is one line of Pulumi.
Three places, one person, twenty minutes of tab-switching.
-->

---
layout: two-cols
---

::header::

# Two kinds of integration

::left::

<div class="!mt-6">
<div class="!text-[2.2rem] !font-semibold !text-[var(--p-primary)]">MCP — Neo <em>reads</em></div>

<p class="!mt-4 !text-[1.45rem] !leading-relaxed opacity-85">
PagerDuty · Linear · Datadog · Honeycomb · Atlassian · Supabase
</p>

<p class="!mt-6 !text-[1.45rem] !leading-relaxed opacity-85">
Credentials encrypted per organization, decrypted at task time,
<strong>never exposed to the model</strong>, never stored in task state.
</p>
</div>

::right::

<div class="!mt-6">
<div class="!text-[2.2rem] !font-semibold !text-[var(--p-primary)]">Cloud CLI — Neo <em>runs</em></div>

<p class="!mt-4 !text-[1.45rem] !leading-relaxed opacity-85">
<code>aws</code> · <code>gcloud</code> · <code>az</code> · <code>kubectl</code>
</p>

<p class="!mt-6 !text-[1.45rem] !leading-relaxed opacity-85">
Against credentials <strong>you</strong> scope, in Pulumi ESC.
<strong>Pulumi Cloud never stores them.</strong>
</p>
</div>

<!--
The one structural slide in the deck. Everything later refers back to this split.

The distinction that matters: MCP is a read channel into SaaS. CLI integrations
are execution against your cloud, with credentials you own. Different trust
stories, and people care about the second one much more.
-->

---
layout: image-right
image: /img/neo-integration-catalog.png
---

# It's a toggle

<div class="!mt-8 !text-[1.5rem] !leading-relaxed space-y-6">

<p>Settings → Integrations. Six of them, each with an <strong>Authorize</strong> button.</p>

<p class="opacity-85">An organization admin turns one on. That's the whole setup step.</p>

<p class="opacity-85">What used to be a webhook service, a deployment, and a pile of glue code is now a row in a list.</p>

</div>

<!--
Set up the December callback here without spending it — you come back to
"what this used to take" in the Delegate section.
-->

---

# Watch the toggle

<div class="flex justify-center !mt-6">
  <video src="/video/honey-comb.mp4" autoplay loop muted class="rounded-xl shadow-2xl max-h-[62vh]" />
</div>

<!--
🎬 honey-comb.mp4 — 24 seconds, silent, loops.

TALK OVER IT. It loops, so there's no rush and no dead air.

"That's Honeycomb. Same flow for PagerDuty, Linear, Datadog. Authorize, and Neo
can read from it inside a task."
-->

---
layout: statement
---

# Every demo today ends the same way

<p class="!mt-8 !text-[3.4rem] !font-semibold !text-[var(--p-primary)]">a reviewable pull request</p>

<p class="!mt-6 !text-[2rem] text-[var(--p-fg-muted)]">Neo proposes. A human merges.</p>

<!--
LOAD-BEARING. Say it clearly and let it sit.

Two reasons it's here, before any demo:
1. If every demo fails, the argument still landed.
2. It sets up the credential payoff in the Scope section — Neo never needed
   write access, because the output was always a PR.

Called back explicitly on the `pulumi env run` slide.
-->

---
layout: section
---

# Ask

## a ticket becomes a pull request

<StageMap current="connect" />

---

# The work that never reaches the top

<div class="zoom-content">

<p class="!mt-10 !text-[1.7rem] !leading-relaxed">
Tickets pile up not because they're unimportant — because they're <strong>never urgent</strong>.
</p>

<p class="!mt-8 !text-[1.7rem] !leading-relaxed opacity-85">
Bump a provider version. Centralize a secret. Close out a small policy violation.
Each one matters. None of them ever wins the morning.
</p>

<p class="!mt-8 !text-[1.7rem] !leading-relaxed">
And explaining each one to an agent is its own overhead — which is the part
integrations remove.
</p>

</div>

<style scoped>
.zoom-content { zoom: 1.4; }
</style>

<!--
Last line is the pivot: the fix isn't a better prompt, it's letting Neo read the
ticket itself — title, description, acceptance criteria — the way an engineer
would.
-->

---
layout: statement
---

# 🔴 Live

<p class="!mt-8 !text-[2.6rem] !text-[var(--p-primary)] !font-semibold">A Linear ticket, start to pull request</p>

<p class="!mt-8 !text-[1.7rem] text-[var(--p-fg-muted)]">pulumi neo</p>

<!--
🔴 LIVE DEMO 1 — target 5 minutes, hard stop 7.

  pulumi neo
  > Implement <TICKET-ID> in this stack.

Narrate while it works — don't watch it in silence:
- it's reading the ticket, not me pasting the ticket
- plan mode first, so I see the resources before anything happens
- the PR gets linked back on the ticket

FALLBACK: play /video/neo-linear.mp4 (76s) — it's the same thing, in the same
CLI. Switch without apologizing for it.

DO NOT debug live past one retry. Go to the video and keep the clock.
-->

---

# What just happened

<div class="zoom-content">

<ul class="!mt-8 !text-[1.55rem] !leading-relaxed space-y-5">
  <li>One integration, authorized once by an admin</li>
  <li>Neo read the <strong>ticket itself</strong> — title, description, acceptance criteria</li>
  <li>It planned against the real stack, not a guess about the stack</li>
  <li>Output was a <strong>pull request</strong>, and a comment back on the ticket</li>
</ul>

<p class="!mt-10 !text-[1.6rem] !leading-relaxed opacity-85">
The ticket and the PR end up linked. The backlog gets shorter.
</p>

</div>

<style scoped>
.zoom-content { zoom: 1.4; }
</style>

<!--
Keep this tight — 60 seconds. It's a landing, not a recap.
-->

---
layout: section
---

# Delegate

## a page fires, and the picture is already assembled

<StageMap current="incident" />

---

# On-call triage is the first twenty minutes

<div class="zoom-content">

<p class="!mt-10 !text-[1.7rem] !leading-relaxed">
You get paged because something is red. You don't know why yet.
</p>

<p class="!mt-8 !text-[1.7rem] !leading-relaxed opacity-85">
So the first twenty minutes aren't fixing. They're <strong>assembling</strong> — what deployed
recently, what changed in the stack, what the metrics did, when it started.
</p>

<p class="!mt-8 !text-[1.7rem] !leading-relaxed">
That assembly is reading. Which is exactly what an integration is for.
</p>

</div>

<style scoped>
.zoom-content { zoom: 1.4; }
</style>

<!--
Room-recognition slide. Anyone who has carried a pager knows the twenty minutes.

Don't claim Neo fixes incidents. Claim it collapses the assembly step — that's
both true and the more credible pitch.
-->

---
layout: two-cols
---

::header::

# December: what this took

::left::

<div class="!mt-4 !text-[1.35rem] !leading-relaxed space-y-4">

<p class="!font-semibold !text-[var(--p-primary)] !text-[1.6rem]">Engin Diri, Dec 2025</p>

<p><em>Day-2 Autonomous Infrastructure Management</em></p>

<p class="opacity-85">Falco · Trivy · Kyverno · Prometheus, on a Kubernetes cluster</p>

<p class="opacity-85">→ Falcosidekick / Alertmanager</p>

<p class="opacity-85">→ <strong>PagerDuty</strong></p>

<p class="opacity-85">→ a webhook service he wrote and deployed</p>

<p class="opacity-85">→ the Neo API, creating a task</p>

</div>

::right::

<div class="!mt-4 !text-[1.4rem] !leading-relaxed space-y-6">

<p>Detection was the easy part. The hard part was <strong>the glue</strong>.</p>

<p class="opacity-85">A service that catches <code>incident.trigger</code>, pulls the alert
detail, and hands Neo the repo, org, project, stack, and environment as context.</p>

<p class="opacity-85">Every one of those wires was code someone had to write, deploy,
and keep running.</p>

</div>

<!--
Credit him properly — this was his workshop, and I co-presented it.

Recording: youtube.com/watch?v=nx6oJvX2JNE
Repo: github.com/dirien/pulumi-ai-workshop-base

The point of the slide is not "look how hard it was." It's setting up an honest
comparison on the next slide — which is NOT "all of this is gone."
-->

---
layout: two-cols
---

::header::

# What changed, precisely

::left::

<div class="!mt-6 !text-[1.5rem] !leading-relaxed">

<p class="!text-[1.9rem] !font-semibold !text-[var(--p-primary)]">The reading half</p>

<p class="!mt-4 opacity-85">Neo pulling incident detail while it works.</p>

<p class="!mt-6 !font-semibold">That's now a toggle.</p>

</div>

::right::

<div class="!mt-6 !text-[1.5rem] !leading-relaxed">

<p class="!text-[1.9rem] !font-semibold opacity-70">The triggering half</p>

<p class="!mt-4 opacity-85">A page automatically starting a task.</p>

<p class="!mt-6 !font-semibold opacity-85">Still the webhook. Still yours to wire.</p>

</div>

<!--
⛔ DO NOT SAY the integration replaced what Engin built. It didn't.

Inbound vs outbound:
- his webhook = INBOUND. PagerDuty fires -> Neo API creates a task.
- MCP integration = OUTBOUND. Neo reads PagerDuty during a task already running.

The line: "the reading half is now a toggle; the triggering half is still yours
to wire."

Being precise here costs nothing and buys credibility for the whole talk.
-->

---
layout: statement
---

# 🔴 Live

<p class="!mt-8 !text-[2.6rem] !text-[var(--p-primary)] !font-semibold">A real page, to a merged fix</p>

<p class="!mt-8 !text-[1.7rem] text-[var(--p-fg-muted)]">PagerDuty + aws, from the terminal</p>

<!--
🔴 LIVE DEMO 2 — target 15 minutes. THE session. Never cut.

  1. Trigger the incident — real page, real timestamp, in front of them
  2. pulumi neo
     > There's an active PagerDuty incident. What's going on?
  3. Neo reads the incident            (PagerDuty, MCP)
  4. Neo inspects what's running       (aws, ESC-backed)
  5. Neo edits the program, previews
  6. PR opens. Resolve back to PagerDuty.

Narrate the seams — that's where the content is:
- "it's reading the incident, I haven't pasted anything"
- "now it's looking at the live account, not the program"
- "and the fix is a diff, not an API call"

THE FINDING IS CONFIGURATION-SHAPED ON PURPOSE. If asked why not a trend:
a fresh account has no history. Config bugs are visible in one look and are
just as real.

If it dies: say what should have happened, and move to Scope. The argument
from slide 9 already landed.
-->

---

# What just happened

<div class="zoom-content">

<ul class="!mt-8 !text-[1.5rem] !leading-relaxed space-y-5">
  <li>A <strong>real incident</strong>, with a real timestamp — not a fixture</li>
  <li>Neo read it through PagerDuty, and read the live account through <code>aws</code></li>
  <li>It connected the alert to a <strong>specific line in the program</strong></li>
  <li>The fix arrived as a diff, with the evidence sitting next to it</li>
  <li>Nobody opened three consoles</li>
</ul>

</div>

<style scoped>
.zoom-content { zoom: 1.4; }
</style>

<!--
Name the finding out loud and say why it's config-shaped rather than a trend.
Being upfront about the constraint reads as confidence, not as a limitation.
-->

---
layout: section
---

# Scope

## what it can reach, and who decided

<StageMap current="scope" />

---
layout: statement
---

# So what can this thing actually reach?

<p class="!mt-8 !text-[1.9rem] text-[var(--p-fg-muted)]">The question you've been holding since slide one</p>

<!--
Say it before they have to ask it. Naming the discomfort is what makes the next
three slides land.

If someone already asked in chat, credit them by name here.
-->

---
layout: two-cols
---

::header::

# Two credential models

::left::

<div class="!mt-6 !text-[1.4rem] !leading-relaxed space-y-5">

<p class="!text-[1.8rem] !font-semibold !text-[var(--p-primary)]">MCP</p>

<ul class="space-y-3 opacity-85">
  <li>Encrypted at rest, per organization</li>
  <li>Decrypted at task time</li>
  <li><strong>Never exposed to the model</strong></li>
  <li>Never written into task state</li>
</ul>

</div>

::right::

<div class="!mt-6 !text-[1.4rem] !leading-relaxed space-y-5">

<p class="!text-[1.8rem] !font-semibold !text-[var(--p-primary)]">Cloud CLI</p>

<ul class="space-y-3 opacity-85">
  <li>Owned by <strong>Pulumi ESC</strong>, not Pulumi Cloud</li>
  <li>Short-lived, issued at task time via OIDC</li>
  <li>Run <strong>as the user asking</strong></li>
  <li>Only works if <em>you</em> could open that environment</li>
</ul>

</div>

<!--
The last bullet is the one that settles the room:

"Connecting an integration grants nobody access they didn't already have."

Neo isn't a new identity with its own permissions. It acts as you, bounded by
what you could already do.
-->

---

```bash
pulumi env run myorg/neo-workshop/aws-readonly -- aws rds describe-db-instances
```

<div class="zoom-content">

<p class="!mt-12 !text-[1.65rem] !leading-relaxed">
That's the entire mechanism. ESC opens the environment, materializes short-lived
credentials, runs the command, tears it back down.
</p>

<p class="!mt-8 !text-[1.65rem] !leading-relaxed !text-[var(--p-primary)] !font-semibold">
Read the role name again. Neo never needed write access to do any of this.
</p>

<p class="!mt-8 !text-[1.65rem] !leading-relaxed opacity-85">
Because the output was always a pull request.
</p>

</div>

<style scoped>
.zoom-content { zoom: 1.3; }
</style>

<!--
THE PAYOFF. This is why slide 9 exists.

Pause after "never needed write access." Let them do the arithmetic themselves.

If someone pushes on it: yes, you can scope it wider, and named instances let you
run production-aws and staging-aws side by side. But the demo they just watched
ran read-only.
-->

---

# Least privilege, from the thing you suspect has too much

<div class="flex justify-center !mt-4">
  <video src="/video/iam-narrow.mp4" autoplay loop muted class="rounded-xl shadow-2xl max-h-[58vh]" />
</div>

<!--
🎬 iam-narrow.mp4 — 60 seconds. Long enough to narrate straight through.

"Forty roles in production. Half of them started with s3:* because nobody had
time to scope them."

Neo cross-references each role's policy against what the stack code actually
calls, and opens a PR per role. The PR body lists the API calls it found —
s3:GetObject on audit-logs-*, s3:PutObject on audit-logs-staging — as the
justification.

The evidence sits next to the diff. That's the pattern worth pointing at.
-->

---
layout: two-cols
---

::header::

# You stay in control of the blast radius

::left::

<div class="!mt-6 !text-[1.45rem] !leading-relaxed space-y-5">

<p class="!text-[1.75rem] !font-semibold !text-[var(--p-primary)]">Per-task toggles</p>

<p class="opacity-85">An admin enables an integration for the org.
<strong>Any single task can switch it off</strong> from the composer — no org config change,
no ticket.</p>

</div>

::right::

<div class="!mt-6 !text-[1.45rem] !leading-relaxed space-y-5">

<p class="!text-[1.75rem] !font-semibold !text-[var(--p-primary)]">Named instances</p>

<p class="opacity-85"><code>production-aws</code> and <code>staging-aws</code>, each with its own
environment and its own scope.</p>

<p class="opacity-85">Each carries a note Neo reads when deciding which to reach for —
<em>"compliance account, avoid mutations."</em></p>

</div>

<!--
This is the "I want this but not everywhere" answer. Worth landing because it's
the objection that stops adoption inside larger orgs.
-->

---
layout: section
---

# Stop initiating

## the part where you're not in the loop anymore

<StageMap current="beyond" />

---
layout: quote
---

> Platform engineers used to keep these things in their heads. Then they delegated them to Neo. Then those tasks started running on a schedule, without anyone initiating them.

<!--
This is the thesis of the whole hour, and it's worth reading slowly.

Everything so far has been you asking. The last move is not asking.
-->

---

# Set it once

<div class="flex justify-center gap-8 !mt-6">
  <video src="/video/neo-schedule-setup.mp4" autoplay loop muted class="rounded-xl shadow-2xl max-h-[52vh]" />
  <video src="/video/neo-cis-pr.mp4" autoplay loop muted class="rounded-xl shadow-2xl max-h-[52vh]" />
</div>

<!--
🎬 Two short clips, 18s and 17s, side by side and looping.

They're SHORT — narrate deliberately or they read as motion rather than content.

Left: the scheduling UI.
  > Every morning, read CIS Benchmark failures from Security Hub. For every
  > failure on an IaC-managed resource, open a PR with the fix.

Right: what shows up the next morning. Point at the PR body — the CIS rule
number, the resource id, the diff, and a clean preview against live infra.

Note out loud: this is the one thing I cannot demo live. A task that runs at
6 AM does not run at 12:45 PM.
-->

---
layout: image-right
image: /img/neo-drift-pr.png
---

# The runbook decides

<div class="!mt-8 !text-[1.45rem] !leading-relaxed space-y-5">

<p>Not every drift should be reverted.</p>

<p class="opacity-85">The security team's IAM rotation gets <strong>encoded</strong>.
A console-added security group rule gets <strong>reverted</strong>.
Autoscaler-managed concurrency gets <strong>ignored</strong>.</p>

<p class="opacity-85">You write that down once. Neo reads it every morning and cites the
section it followed.</p>

</div>

<!--
This is the slide that separates "scheduled automation" from "an agent running
unsupervised." The judgment stays in a file your team wrote.

The PR body names the resource, the change, when it happened, and the runbook
section. That citation is the trust mechanism.
-->

---
layout: two-cols
---

::header::

# Where this goes next

::left::

<div class="!mt-6 !text-[1.4rem] !leading-relaxed space-y-6">

<p><strong class="!text-[var(--p-primary)]">Automations</strong><br/>
<span class="opacity-85">Cloud CLI access inside scheduled tasks, not just ones you start.</span></p>

<p><strong class="!text-[var(--p-primary)]">Your editor</strong><br/>
<span class="opacity-85">Neo in Zed, JetBrains, VS Code, Cursor.</span></p>

</div>

::right::

<div class="!mt-6 !text-[1.4rem] !leading-relaxed space-y-6">

<p><strong class="!text-[var(--p-primary)]">Handoff</strong><br/>
<span class="opacity-85">Claude Code and other agents can start a <code>pulumi neo</code> task
and hand infrastructure work over.</span></p>

</div>

<!--
Keep this to 90 seconds. It's a horizon slide, not a roadmap commitment.

⛔ Do NOT promise Custom Agents. Not announced. Engin's Sep 23 AKS session is
where that lives — point people there if asked.

FIRST THING CUT if running long.
-->

---
layout: end
---

# Thanks

<div class="flex justify-center gap-10 !mt-8">

  <div class="text-center">
    <img src="/img/qr-repo.png" class="w-52" alt="Workshop repo" />
    <p class="!mt-3 !text-[1.15rem] opacity-80 !m-0">Slides &amp; repo</p>
  </div>

  <div class="text-center">
    <img src="/img/qr-blog.png" class="w-52" alt="Ten More Things blog post" />
    <p class="!mt-3 !text-[1.15rem] opacity-80 !m-0">Ten More Things</p>
  </div>

  <div class="text-center">
    <img src="/img/qr-docs.png" class="w-52" alt="Neo integrations docs" />
    <p class="!mt-3 !text-[1.15rem] opacity-80 !m-0">Integrations docs</p>
  </div>

  <div class="text-center">
    <img src="/img/qr-emea.png" class="w-52" alt="EMEA session Sep 30" />
    <p class="!mt-3 !text-[1.15rem] opacity-80 !m-0">EMEA — Sep 30</p>
  </div>

</div>

<p class="!mt-10 !text-[1.9rem] !font-semibold text-center">Questions?</p>

<!--
⚠️ THESE QR CODES ARE PLACEHOLDERS — grey, hatched, and labelled so they cannot
ship by accident. Three of the four already point at real URLs (blog, docs,
event page); the repo one points at github.com/PLACEHOLDER/... and must be
regenerated once the repo has a home.

Regenerate: scripts/make-qr.py (segno + pillow). Drop the hatch and the bar,
switch dark= to the brand violet, and fix the repo URL.

Leave this slide up through Q&A.
-->
