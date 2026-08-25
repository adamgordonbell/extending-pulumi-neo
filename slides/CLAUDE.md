<!-- FOR AI AGENTS - Human readability is a side effect, not a goal -->

# AGENTS.md — `slides/`

Slidev presentation deck for the workshop, built on the `@pulumi/slidev-theme`.
The single source of the deck is `slides.md`; shared styling lives in `style.css`;
all images and fonts are under `public/`.

## Commands

| Task | Command | Notes |
|------|---------|-------|
| Install deps | `npm install` | Tokenless — pulls `@pulumi/slidev-theme` from public npm |
| Dev server | `npm run dev -- --port 3030` | |
| Build static site | `npm run build` | Outputs to `dist/` (gitignored) |
| Export to PDF/PNG | `npm run export` | Needs `playwright-chromium` (install with `--no-save`) |

## No auth needed to install

`@pulumi/slidev-theme` is published on the public npm registry, so `npm install`
runs without any token. (There is no `.npmrc` scope redirect — an earlier version
pointed `@pulumi` at GitHub Packages, which required a `GITHUB_TOKEN`; that is gone.)

## Conventions

- **One file:** all slides live in `slides.md`. Slides are separated by `---` on its
  own line; a `---` … `---` block right after a separator is per-slide frontmatter.
- **Theme colors:** use the theme CSS vars (`var(--p-primary)`, `var(--p-fg-muted)`,
  `var(--p-bg-code)`, …), not hardcoded hex, so dark/light mode both work.
- **Dark/light logo swap:** drive variant visibility off the theme tokens
  `--p-logo-light-display` / `--p-logo-dark-display` (see the CascadiaJS + Strands logos).
- **Pin a slide dark:** add `class: dark` to that slide's frontmatter.
- **Full-bleed image:** hide chrome per-slide with scoped
  `:deep(.pulumi-accent-bar), :deep(.pulumi-footer) { display: none }` and
  `:deep(.pulumi-slide-body) { padding: 0 }`. This repeats across slides by design —
  `<style scoped>` is per-slide and cannot be hoisted without losing scoping.
- **Float over the footer:** the footer is `position: absolute; z-index: 10`; give an
  overlay a higher `z-index` to sit on top of it.
- **QR codes** are pre-rendered PNGs in `public/img/` (generated with `segno`), not a
  runtime component — avoids adding an npm dependency.
- **Code blocks** use real fenced ```` ```lang ```` blocks (Shiki `min-dark` on the
  Pulumi violet background), never screenshots.
- **Restart the dev server after inserting or removing a slide.** Slide modules are
  keyed by slide index, so an insertion shifts every later slide and stale HMR state
  can silently drop a slide's `<style scoped>` (symptom: a slide renders unstyled,
  e.g. absolutely-positioned overlays pile up top-left). In-place content edits
  hot-reload fine; `npm run build` is unaffected.

## Stage navigation (`StageMap` + `global-top.vue`)

The `why · ask · delegate · scope · unattended` strip is both a place-marker and a
jump table. Adapted from `build-your-own-iac`'s `ActNav.vue`.

- **Positions are derived, never hardcoded.** Each section divider carries
  `routeAlias: stage-<name>`; `StageMap` walks `nav.slides` to find them. Inserting or
  cutting slides never touches the component — only the dividers carry position.
- **Two sizes.** `size="lg"` sits on the dividers (names always shown, struck through
  once passed). `size="sm"` is rendered on every other slide by `global-top.vue`, in the
  top-right corner.
- **State is carried by shape, not colour** (Adam is red-green colourblind): `▪` for
  ground covered, `◦` for still ahead, and only the current stage shows its name.
  The `lg` strip additionally strikes through completed stages.
- **Every entry is a button** — `nav.go()` to that section. Works in both sizes.
- **The five tokens are also the agenda slide, verbatim.** Strip, section headings and
  "Where we're going" must stay identical — it is a navigation aid, so a heading that
  doesn't match the token you clicked is a real cost. Change all three together.
- `global-top.vue` hides the strip on the cover, the dividers (they render `lg`
  themselves) and the end. It detects dividers by `routeAlias`, **not** by layout name —
  slidev consumes `layout` before frontmatter is readable there.

### Known limitation: static export

During `slidev export` (PNG/PDF) slidev pins both `nav.currentSlideNo` and `$page` to
**1** for every rendered slide, so position-derived state cannot resolve. `StageMap`
renders nothing in that case rather than showing a wrong state (`v-if="here"`).
⚠️ The theme's own footer has the same problem and reads `1 / 32` on every exported
slide — that is upstream, not ours. **The strip is a live-presentation aid; don't judge
it from the exported PDF.**

## Boundaries

### Always Do
- Keep `style.css` lean — it holds global theme overrides + shared helpers only;
  one-off slide styling belongs in that slide's `<style scoped>`.
- Reference theme color vars, not hardcoded hex.
- Run `npm run build` after edits to confirm the deck still compiles.

### Ask First
- Adding an npm dependency (prefer pre-rendering assets, e.g. QR PNGs via `segno`).

### Never Do
- Commit `node_modules/`, `dist/`, or `.slidev/` (all gitignored).
- Commit any credential or token.
