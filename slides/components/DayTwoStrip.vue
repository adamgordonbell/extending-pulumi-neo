<template>
  <!-- Day one is one green check. Day two is everything that comes after, spread along a line that runs off the slide. -->
  <div class="d2">
    <div class="d2-row">
      <div class="d2-day1">
        <div class="d2-lbl">day one</div>
        <div class="d2-box">
          <ph-check-circle class="d2-ico" />
          <div class="d2-cap"><code>pulumi up</code><br/>green check</div>
        </div>
      </div>
      <div class="d2-arrow"><ph-arrow-right /></div>
      <div class="d2-day2">
        <div class="d2-lbl">day two, and every day after</div>
        <div class="d2-line">
          <div class="d2-ev"><ph-bell-ringing class="d2-ico" /><div class="d2-cap">the alert at 2am</div></div>
          <div class="d2-ev"><ph-package class="d2-ico" /><div class="d2-cap">the provider that went out of date</div></div>
          <div class="d2-ev"><ph-shield-warning class="d2-ico" /><div class="d2-cap">the security group added by hand</div></div>
          <div class="d2-ev"><ph-hourglass-high class="d2-ico" /><div class="d2-cap">the upgrade nobody has time for</div></div>
          <div class="d2-ev d2-more"><ph-dots-three class="d2-ico" /><div class="d2-cap">&nbsp;</div></div>
        </div>
      </div>
    </div>
  </div>
</template>
<style scoped>
.d2 { margin-top: 3rem; }
.d2-row { display: flex; align-items: stretch; gap: 1.6rem; }
.d2-lbl { font-size: 1.15rem; font-weight: 600; letter-spacing: .04em; text-transform: uppercase; color: var(--p-fg-muted); margin-bottom: 1rem; }
.d2-day1 { flex: 0 0 15rem; }
.d2-box { border: 2px solid var(--p-primary); border-radius: .9rem; padding: 1.6rem 1rem; text-align: center; }
.d2-arrow { display: flex; align-items: center; font-size: 2.6rem; color: var(--p-fg-muted); padding-top: 2rem; }
.d2-day2 { flex: 1; min-width: 0; }
.d2-line { display: flex; gap: 1.2rem; border-top: 2px dashed var(--p-fg-muted); padding-top: 1.6rem; }
.d2-ev { flex: 1; text-align: center; }
.d2-more { flex: 0 0 4rem; opacity: .45; }
.d2-ico { font-size: 3.4rem; color: var(--p-primary); }
.d2-cap { margin-top: .6rem; font-size: 1.25rem; line-height: 1.35; }
</style>
