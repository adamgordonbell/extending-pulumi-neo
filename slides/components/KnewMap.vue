<template>
  <!-- What Neo already had (inside the box Pulumi records) versus what it could not see (outside, greyed). -->
  <div class="km">
    <div class="km-box">
      <div class="km-lbl">what Pulumi records</div>
      <div class="km-inner">
        <div class="km-col">
          <div class="km-item"><ph-file-code class="km-ico" /><span>programs</span></div>
          <div class="km-item"><ph-stack class="km-ico" /><span>stacks &amp; state</span></div>
          <div class="km-item"><ph-books class="km-ico" /><span>providers &amp; registry</span></div>
        </div>
        <div class="km-neo"><NeoIcon /></div>
        <div class="km-col">
          <div class="km-item"><ph-eye class="km-ico" /><span>preview</span></div>
          <div class="km-item"><ph-shield-check class="km-ico" /><span>policy</span></div>
          <div class="km-item"><ph-git-pull-request class="km-ico" /><span>pull request</span></div>
        </div>
      </div>
    </div>
    <div class="km-out">
      <div class="km-lbl">what it never records</div>
      <div class="km-item out"><ph-bell-ringing class="km-ico" /><span>the page in PagerDuty</span></div>
      <div class="km-item out"><ph-ticket class="km-ico" /><span>the ticket in Linear</span></div>
      <div class="km-item out"><ph-chart-line class="km-ico" /><span>the metric in Datadog</span></div>
      <div class="km-item out"><ph-shield-warning class="km-ico" /><span>the security group added by hand</span></div>
    </div>
  </div>
</template>
<style scoped>
.km { margin-top: 2.4rem; display: grid; grid-template-columns: 3fr 2fr; gap: 3rem; align-items: start; }
.km-lbl { font-size: 1.1rem; font-weight: 600; letter-spacing: .04em; text-transform: uppercase; color: var(--p-fg-muted); margin-bottom: 1rem; }
.km-box { border: 2px solid var(--p-primary); border-radius: 1.1rem; padding: 1.3rem 1.6rem 1.6rem; }
.km-inner { display: grid; grid-template-columns: 1fr auto 1fr; gap: 1.6rem; align-items: center; }
.km-col { display: flex; flex-direction: column; gap: .9rem; }
.km-item { display: flex; align-items: center; gap: .9rem; font-size: 1.4rem; font-weight: 600; border: 2px solid var(--p-border); border-radius: .7rem; padding: .7rem 1rem; }
.km-ico { font-size: 2.1rem; color: var(--p-primary); flex: 0 0 auto; }
.km-neo { width: 7.5rem; height: 7.5rem; border-radius: 50%; border: 2px solid var(--p-primary); display: flex; align-items: center; justify-content: center; font-size: 4.6rem; color: var(--p-primary); }
.km-out { display: flex; flex-direction: column; gap: .9rem; padding-top: .2rem; }
.km-item.out { border-style: dashed; opacity: .55; font-weight: 500; }
.km-item.out .km-ico { color: var(--p-fg-muted); }
</style>
