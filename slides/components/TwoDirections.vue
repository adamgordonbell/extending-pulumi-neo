<template>
  <!-- Out, to the systems you operate with. In, from where you already work. Neo in the middle. -->
  <div class="td">
    <div class="td-side">
      <div class="td-lbl">in — from where you already work</div>
      <div class="td-cards">
        <div class="td-card"><carbon-logo-github class="td-ico" /><span>GitHub</span></div>
        <div class="td-card"><carbon-logo-slack class="td-ico" /><span>Slack</span></div>
      </div>
      <div class="td-note">how the work gets started</div>
    </div>
    <div class="td-arrow"><ph-arrow-right /></div>
    <div class="td-neo"><NeoIcon /></div>
    <div class="td-arrow"><ph-arrow-right /></div>
    <div class="td-side">
      <div class="td-lbl">out — to the systems you operate with</div>
      <div class="td-cards">
        <div class="td-card"><ph-plugs-connected class="td-ico" /><span>MCP<small>PagerDuty · Linear · Datadog · Honeycomb</small></span></div>
        <div class="td-card"><ph-terminal class="td-ico" /><span>Cloud CLI<small>aws · gcloud · az · kubectl</small></span></div>
      </div>
      <div class="td-note">what Neo can see</div>
    </div>
  </div>
</template>
<style scoped>
.td { margin-top: 2.8rem; display: grid; grid-template-columns: 1fr auto auto auto 1fr; align-items: center; gap: 1.2rem; }
.td-lbl { font-size: 1.1rem; font-weight: 600; letter-spacing: .04em; text-transform: uppercase; color: var(--p-fg-muted); margin-bottom: .8rem; }
.td-cards { display: flex; flex-direction: column; gap: .8rem; }
.td-card { display: flex; align-items: center; gap: 1rem; border: 2px solid var(--p-border); border-radius: .8rem; padding: .9rem 1.1rem; font-size: 1.45rem; font-weight: 600; }
.td-card small { display: block; font-size: 1rem; font-weight: 400; opacity: .7; margin-top: .15rem; }
.td-ico { font-size: 2.4rem; color: var(--p-primary); flex: 0 0 auto; }
.td-note { margin-top: .8rem; font-size: 1.15rem; font-style: italic; opacity: .7; }
.td-arrow { font-size: 3rem; color: var(--p-fg-muted); }
.td-neo { width: 8rem; height: 8rem; border-radius: 50%; border: 2px solid var(--p-primary); display: flex; align-items: center; justify-content: center; font-size: 5rem; color: var(--p-primary); }
</style>
