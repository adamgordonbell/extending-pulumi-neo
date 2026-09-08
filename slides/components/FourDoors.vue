<template>
  <!-- One Neo, four doorways. Same agent, same integrations, same permissions. -->
  <div class="fd">
    <div class="fd-door"><ph-browser class="fd-ico" /><div class="fd-name">Pulumi Cloud</div><div class="fd-sub">integrations on; task history</div></div>
    <div class="fd-door"><ph-terminal-window class="fd-ico" /><div class="fd-name"><code>pulumi neo</code></div><div class="fd-sub">everything you watched today</div></div>
    <div class="fd-door"><ph-code class="fd-ico" /><div class="fd-name">your editor</div><div class="fd-sub">Zed · JetBrains · VS Code · Cursor</div></div>
    <div class="fd-door"><ph-calendar-check class="fd-ico" /><div class="fd-name">on a schedule</div><div class="fd-sub">nobody is there at all</div></div>
    <div class="fd-center">
      <div class="fd-lines"></div>
      <div class="fd-neo"><NeoIcon /></div>
    </div>
  </div>
</template>
<style scoped>
.fd { position: relative; margin-top: 2.6rem; display: grid; grid-template-columns: 1fr 1fr; grid-template-rows: 1fr 1fr; gap: 2.2rem 22rem; }
.fd-door { border: 2px solid var(--p-border); border-radius: 1rem; padding: 1.3rem 1.2rem; text-align: center; }
.fd-ico { font-size: 3.4rem; color: var(--p-primary); }
.fd-name { margin-top: .4rem; font-size: 1.55rem; font-weight: 600; color: var(--p-primary); }
.fd-sub { margin-top: .3rem; font-size: 1.1rem; opacity: .75; }
.fd-center { position: absolute; inset: 0; display: flex; align-items: center; justify-content: center; pointer-events: none; }
.fd-neo { position: relative; width: 9rem; height: 9rem; border-radius: 50%; border: 2px solid var(--p-primary); display: flex; align-items: center; justify-content: center; font-size: 5.6rem; color: var(--p-primary); background: var(--p-bg); }
.fd-lines { position: absolute; left: 50%; top: 50%; width: 22rem; height: 2px; transform: translate(-50%, -50%); background: var(--p-border); }
</style>
