<script setup>
defineProps({ current: String })
const stages = ['why', 'connect', 'incident', 'scope', 'beyond']
</script>

<template>
  <div class="stage-map">
    <template v-for="(s, i) in stages" :key="s">
      <span v-if="i" class="stage-sep">·</span>
      <span class="stage" :class="{ active: s === current }">{{ s }}</span>
    </template>
  </div>
</template>

<style scoped>
.stage-map {
  position: absolute;
  bottom: 2.4rem;
  left: 0;
  right: 0;
  display: flex;
  justify-content: center;
  align-items: baseline;
  gap: 1.1rem;
  font-family: var(--slidev-font-mono);
  font-size: 1.35rem;
  letter-spacing: 0.06em;
  z-index: 10;
}
.stage {
  color: var(--p-fg-muted);
  opacity: 0.45;
}
.stage.active {
  color: var(--p-primary);
  opacity: 1;
  font-weight: 700;
  text-decoration: underline;
  text-underline-offset: 0.45em;
}
.stage-sep {
  color: var(--p-fg-muted);
  opacity: 0.3;
}
</style>
