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
routeAlias: preview-day-two
---

# Day two

<DayTwoStrip />

<p class="!mt-8 !text-[1.7rem] !leading-relaxed !text-[var(--p-primary)] !font-semibold text-center">
Day one makes a good demo. Day two is a job, and it is what the rest of this hour is about.
</p>

---
routeAlias: preview-what-neo-is
---

# What Neo is

<img src="/img/neo-hero.svg" class="!mt-6 mx-auto max-h-[52vh]" alt="A prompt to Neo on the left, Neo in the middle, three upgraded EKS clusters on the right" />

<p class="!mt-6 !text-[1.6rem] !leading-relaxed text-center opacity-85">
Ask, and it answers, investigates, reviews, or opens a pull request. The result is a diff your reviewers still gate.
</p>

---
routeAlias: preview-read-write
---

# It reads with the CLI. It writes with Pulumi.

<ReadWrite />

<p class="!mt-8 !text-[1.45rem] !leading-relaxed text-center opacity-85">
The CLI can only do what its credentials allow. You choose the role. Give it a <strong>read-only</strong> one and the pull request is the only way to change anything.
</p>

---
routeAlias: preview-four-doors
---

# Same agent, four places

<FourDoors />

<p class="!mt-7 !text-[1.5rem] !leading-relaxed text-center">
Same integrations, same permissions. Only the doorway changes.
</p>

---
routeAlias: preview-two-directions
---

# Two directions

<TwoDirections />
