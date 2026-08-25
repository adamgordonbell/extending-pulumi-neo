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
60 minutes. Demo-driven. Everything ends in a pull request.
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

---

# Housekeeping

<div class="zoom-content">

<ul class="!mt-8 !text-[1.6rem] !leading-relaxed space-y-5">
  <li>I'll <strong>present and demo</strong> — no need to follow along live</li>
  <li>Ask questions <strong>any time</strong>; treat this as a conversation</li>
  <li>Slides and the demo repo go home with you (QR at the end)</li>
  <li>There's an <strong>EMEA repeat on Sep 30</strong> with Engin Diri</li>
</ul>

</div>

<style scoped>
.zoom-content { zoom: 1.7; }
</style>

---

# Today

<div class="zoom-content">

<ul class="!mt-8 !text-[1.55rem] !leading-relaxed space-y-4">
  <li><strong class="!text-[var(--p-primary)]">Why</strong> — the gap between writing infra and understanding it</li>
  <li><strong class="!text-[var(--p-primary)]">Connect</strong> — a ticket becomes a pull request</li>
  <li><strong class="!text-[var(--p-primary)]">Incident</strong> — page to merged fix, live</li>
  <li><strong class="!text-[var(--p-primary)]">Scope</strong> — what Neo can reach, and who decided</li>
  <li><strong class="!text-[var(--p-primary)]">Beyond</strong> — automations and your editor</li>
</ul>

</div>

<style scoped>
.zoom-content { zoom: 1.6; }
</style>

---

<div class="absolute inset-0 flex flex-col justify-center items-center px-20 text-center">
  <h1 class="!text-[7.5rem] !leading-tight !font-semibold !tracking-tight !m-0 !text-[var(--p-primary)]">Why</h1>
  <p class="!mt-4 !text-[2rem] text-[var(--p-fg-muted)] !m-0">the gap between writing infra and understanding it</p>
</div>

<StageMap current="why" />

---

# Neo could always write Pulumi

<div class="zoom-content">

<p class="!mt-10 !text-[1.7rem] !leading-relaxed">
What it couldn't do was <strong>look at the systems the incident actually lives in.</strong>
</p>

<p class="!mt-8 !text-[1.7rem] !leading-relaxed opacity-80">
The alert is in PagerDuty. The ticket is in Linear. The truth about what's
running is in the cloud account — not in the program.
</p>

<p class="!mt-8 !text-[1.7rem] !leading-relaxed">
So a human reads three consoles, then writes the change.
</p>

</div>

<style scoped>
.zoom-content { zoom: 1.45; }
</style>

<!--
Don't oversell. The gap is real and specific: context, not capability.
-->

---

# Two kinds of integration

<div class="zoom-content">

<ul class="!mt-8 !text-[1.55rem] !leading-relaxed space-y-6">
  <li>
    <strong class="!text-[var(--p-primary)]">MCP</strong> — Neo <em>reads</em> your SaaS.<br/>
    <span class="opacity-75">PagerDuty · Linear · Datadog · Honeycomb · Atlassian · Supabase</span><br/>
    <span class="opacity-75">Credentials encrypted per-org, decrypted at task time, never shown to the model.</span>
  </li>
  <li>
    <strong class="!text-[var(--p-primary)]">Cloud CLI</strong> — Neo <em>runs</em> <code>aws</code>, <code>gcloud</code>, <code>az</code>, <code>kubectl</code>.<br/>
    <span class="opacity-75">Against credentials you scope yourself, in Pulumi ESC.</span><br/>
    <span class="opacity-75">Pulumi Cloud never stores them.</span>
  </li>
</ul>

</div>

<style scoped>
.zoom-content { zoom: 1.4; }
</style>

---

<div class="absolute inset-0 flex flex-col justify-center items-center px-20 text-center">
  <h1 class="!text-[5.5rem] !leading-tight !font-semibold !tracking-tight !m-0 !max-w-[90%]">
    Every demo today ends the same way
  </h1>
  <p class="!mt-8 !text-[3rem] !m-0 !text-[var(--p-primary)] !font-semibold">a reviewable pull request</p>
  <p class="!mt-6 !text-[1.9rem] text-[var(--p-fg-muted)] !m-0">Neo proposes. A human merges.</p>
</div>

<!--
This is the load-bearing slide. Say it early, come back to it in Scope.
-->

---

<div class="absolute inset-0 flex flex-col justify-center items-center px-20 text-center">
  <h1 class="!text-[7.5rem] !leading-tight !font-semibold !tracking-tight !m-0 !text-[var(--p-primary)]">Connect</h1>
  <p class="!mt-4 !text-[2rem] text-[var(--p-fg-muted)] !m-0">a ticket becomes a pull request</p>
</div>

<StageMap current="connect" />

---

# Demo — Linear

<div class="zoom-content">

<p class="!mt-10 !text-[1.7rem] !leading-relaxed">
One integration. About thirty seconds of setup.
</p>

<ol class="!mt-8 !text-[1.6rem] !leading-relaxed space-y-4">
  <li>A ticket describing an infrastructure change</li>
  <li><code>pulumi neo</code> — ask it to pick the ticket up</li>
  <li>Neo reads the ticket, edits the program, opens a PR</li>
</ol>

</div>

<style scoped>
.zoom-content { zoom: 1.45; }
</style>

<!--
DEMO 1 (~7 min). Cheapest possible proof.
If running long: this becomes a screenshot.
-->

---

<div class="absolute inset-0 flex flex-col justify-center items-center px-20 text-center">
  <h1 class="!text-[7.5rem] !leading-tight !font-semibold !tracking-tight !m-0 !text-[var(--p-primary)]">Incident</h1>
  <p class="!mt-4 !text-[2rem] text-[var(--p-fg-muted)] !m-0">page to merged fix, live</p>
</div>

<StageMap current="incident" />

---

# Standing on Engin's work

<div class="zoom-content">

<p class="!mt-8 !text-[1.65rem] !leading-relaxed">
<strong>Day-2 Autonomous Infrastructure Management</strong> — Engin Diri, December 2025.
Detection into PagerDuty, PagerDuty into a Neo task.
</p>

<p class="!mt-8 !text-[1.65rem] !leading-relaxed">
He had to <strong>write the glue</strong>: a webhook service that caught
<code>incident.trigger</code> and called the Neo API.
</p>

<p class="!mt-8 !text-[1.65rem] !leading-relaxed">
Today the <em>reading</em> half is a toggle. <span class="opacity-75">The
<em>triggering</em> half is still his webhook — and still yours to wire.</span>
</p>

</div>

<style scoped>
.zoom-content { zoom: 1.35; }
</style>

<!--
⛔ Do NOT say the integration replaced what he built. Inbound vs outbound.
Recording: youtube.com/watch?v=nx6oJvX2JNE · repo: dirien/pulumi-ai-workshop-base
-->

---

# Demo — the incident

<div class="zoom-content">

<ol class="!mt-8 !text-[1.6rem] !leading-relaxed space-y-4">
  <li>Cause a <strong>real page</strong> — not a fixture</li>
  <li>Neo reads the incident <span class="opacity-70">(PagerDuty, MCP)</span></li>
  <li>Neo inspects what's actually running <span class="opacity-70">(<code>aws</code>, ESC-backed)</span></li>
  <li>Neo edits the program and previews the change</li>
  <li><strong>Pull request.</strong> Resolve back to PagerDuty.</li>
</ol>

</div>

<style scoped>
.zoom-content { zoom: 1.45; }
</style>

<!--
DEMO 2 (~22 min). THE session. Never cut.
Finding must be configuration-shaped, not trend-shaped —
a fresh account has no history.
-->

---

<div class="absolute inset-0 flex flex-col justify-center items-center px-20 text-center">
  <h1 class="!text-[7.5rem] !leading-tight !font-semibold !tracking-tight !m-0 !text-[var(--p-primary)]">Scope</h1>
  <p class="!mt-4 !text-[2rem] text-[var(--p-fg-muted)] !m-0">what Neo can reach, and who decided</p>
</div>

<StageMap current="scope" />

---

# The question you're actually holding

<div class="zoom-content">

<ul class="!mt-8 !text-[1.5rem] !leading-relaxed space-y-5">
  <li>An <strong>org admin</strong> enables an integration. Any single <strong>task</strong> can switch it off, without touching org config.</li>
  <li><strong>MCP credentials</strong> — encrypted at rest per organization, decrypted at task time, never exposed to the model, never in task state.</li>
  <li><strong>CLI credentials</strong> — owned by ESC, not Pulumi Cloud. Neo runs them <strong>as you</strong>. An integration works only for someone who could open that environment themselves.</li>
  <li>Connecting an integration <strong>grants nobody access they didn't already have.</strong></li>
</ul>

</div>

<style scoped>
.zoom-content { zoom: 1.35; }
</style>

---

```bash
pulumi env run myorg/neo-workshop/aws-readonly -- aws rds describe-db-instances
```

<div class="zoom-content">

<p class="!mt-12 !text-[1.7rem] !leading-relaxed">
That's the whole mechanism. ESC opens the environment, materializes the
credentials, runs the command, tears it back down.
</p>

<p class="!mt-8 !text-[1.7rem] !leading-relaxed !text-[var(--p-primary)] !font-semibold">
Note the role name. Neo never needed write access to do any of this.
</p>

<p class="!mt-8 !text-[1.7rem] !leading-relaxed opacity-80">
The remediation was a pull request.
</p>

</div>

<style scoped>
.zoom-content { zoom: 1.35; }
</style>

<!--
Callback to the "every demo ends in a PR" slide. This is the answer to the
question in chat.
-->

---

<div class="absolute inset-0 flex flex-col justify-center items-center px-20 text-center">
  <h1 class="!text-[7.5rem] !leading-tight !font-semibold !tracking-tight !m-0 !text-[var(--p-primary)]">Beyond</h1>
  <p class="!mt-4 !text-[2rem] text-[var(--p-fg-muted)] !m-0">automations and your editor</p>
</div>

<StageMap current="beyond" />

---

# Not just the interactive task

<div class="zoom-content">

<ul class="!mt-10 !text-[1.6rem] !leading-relaxed space-y-6">
  <li><strong class="!text-[var(--p-primary)]">Automations</strong> — CLI integrations inside scheduled Neo tasks, not only ones you start by hand</li>
  <li><strong class="!text-[var(--p-primary)]">Your editor</strong> — Neo in Zed, JetBrains, VS Code, Cursor</li>
</ul>

</div>

<style scoped>
.zoom-content { zoom: 1.5; }
</style>

<!--
PICK ONE before the session. First thing cut if running long.
-->

---

# Thanks

<div class="zoom-content">

<ul class="!mt-10 !text-[1.6rem] !leading-relaxed space-y-4">
  <li>Docs — <strong>pulumi.com/docs/ai/neo/integrations/</strong></li>
  <li>Repo and slides — QR</li>
  <li>EMEA repeat with Engin Diri — <strong>Sep 30</strong></li>
</ul>

<p class="!mt-12 !text-[1.8rem] !leading-relaxed">Questions?</p>

</div>

<style scoped>
.zoom-content { zoom: 1.5; }
</style>
