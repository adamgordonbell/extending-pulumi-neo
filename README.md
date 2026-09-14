# Extending Pulumi Neo: MCP Servers and Cloud CLIs

In this workshop, you will see how to give [Pulumi Neo](https://www.pulumi.com/product/neo/)
access to the systems your incidents actually live in — SaaS tools over **MCP**, cloud
accounts over **CLI integrations**, with credentials scoped in
[Pulumi ESC](https://www.pulumi.com/docs/esc/). Every demo ends the same way: a reviewable
pull request. Neo proposes; a human merges.

**Format:** 60 min, demo-driven, watch-style
**Sessions:** Americas — Tue Sep 8 2026 (Adam Gordon Bell) · EMEA — Wed Sep 30 2026 (Engin Diri)

[Registration Link](https://www.pulumi.com/events/extending-pulumi-neo-mcp-cloud-cli/)

## Goals

- Query your whole estate — including resources no Pulumi program describes — with the [Context API](https://www.pulumi.com/blog/pulumi-context-api/)
- Connect Neo outward to PagerDuty, Linear and the `aws` CLI, and inward from GitHub and Slack
- Scope Neo's cloud access per organization and per task using ESC
- Run the same agent from Pulumi Cloud, the terminal, an editor, and on a schedule

## Outline

- What Neo knows: code, stacks, state, and the Context API graph
- **Demo 1**: a Linear ticket becomes a pull request
- **Demo 2**: a PagerDuty page becomes a merged fix, including a finding that exists only in the cloud account
- How access is scoped — MCP integrations, CLI integrations, ESC credentials
- Where Neo runs: Cloud, CLI, editor (ACP), and unattended
- Q&A

## Pre-reqs for the demos

- A Pulumi organization with Neo enabled
- PagerDuty and Linear tokens for the MCP integrations
- An AWS account reachable from an ESC environment (read-only is enough — the pull request is the only write path)
- See [`docs/demo-setup.md`](docs/demo-setup.md) for the account and credential setup

## Running the demos

The live walkthrough is [`demo.md`](demo.md) — run it in your own org.

`demo/context-api/` holds the Context API queries; `demo/pulumi-ts/` is a local checkout
of the incident program, which has its own repo.

## Running the deck

```bash
cd slides
npm install          # no token needed; @pulumi/slidev-theme is on public npm
npm run dev          # http://localhost:3030
npm run build        # static site into dist/
```
