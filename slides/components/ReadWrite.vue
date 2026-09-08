<template>
  <!-- Two arrows. Neo reads the live account through the CLI; it writes only through a pull request that Pulumi applies. -->
  <div class="rw">
    <div class="rw-node rw-cloud">
      <ph-cloud class="rw-ico" />
      <div class="rw-cap">the live account</div>
      <div class="rw-sub">including what Pulumi never managed</div>
    </div>
    <div class="rw-arrows">
      <div class="rw-arrow rw-read">
        <div class="rw-lbl">reads</div>
        <div class="rw-shaft"><ph-arrow-right /></div>
        <div class="rw-tools"><code>aws</code> · <code>gcloud</code> · <code>az</code> · <code>kubectl</code></div>
      </div>
    </div>
    <div class="rw-node rw-neo">
      <NeoIcon class="rw-ico" />
      <div class="rw-cap">Neo</div>
    </div>
    <div class="rw-arrows">
      <div class="rw-arrow rw-write">
        <div class="rw-lbl">writes</div>
        <div class="rw-shaft"><ph-arrow-right /></div>
        <div class="rw-tools">a pull request</div>
      </div>
    </div>
    <div class="rw-node rw-pr">
      <ph-git-pull-request class="rw-ico" />
      <div class="rw-cap">you merge</div>
      <div class="rw-sub">Pulumi makes the change</div>
    </div>
  </div>
</template>
<style scoped>
.rw { margin-top: 3.2rem; display: grid; grid-template-columns: 15rem 1fr 13rem 1fr 15rem; align-items: center; gap: .8rem; }
.rw-node { text-align: center; border-radius: 1rem; padding: 1.4rem .8rem; border: 2px solid var(--p-border); }
.rw-neo { border-color: var(--p-primary); }
.rw-ico { font-size: 4rem; color: var(--p-primary); }
.rw-cap { margin-top: .5rem; font-size: 1.5rem; font-weight: 600; }
.rw-sub { margin-top: .3rem; font-size: 1.05rem; opacity: .7; line-height: 1.3; }
.rw-arrow { text-align: center; }
.rw-lbl { font-size: 1.5rem; font-weight: 700; color: var(--p-primary); text-transform: lowercase; }
.rw-shaft { font-size: 2.8rem; line-height: 1; color: var(--p-fg-muted); }
.rw-read .rw-shaft { transform: scaleX(-1); }
.rw-tools { font-size: 1.15rem; opacity: .8; }
</style>
