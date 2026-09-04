<script setup>
import { computed, onMounted } from 'vue'
import { useNav } from '@slidev/client'

// Corner stage strip. Hidden on the slides that own the whole canvas — the cover,
// the section dividers (they render the big strip themselves), and the end.
//
// Detected via the divider's own `routeAlias: stage-*` rather than the layout name,
// which slidev consumes before frontmatter is readable here.
const nav = useNav()

const fm = computed(() => nav.currentSlideRoute?.value?.meta?.slide?.frontmatter ?? {})

const hidden = computed(() => {
  const f = fm.value
  return /^stage-/.test(f.routeAlias ?? '') || ['cover', 'end'].includes(f.layout)
})

// Any demo clip goes full screen on click, and Esc brings it back. One
// listener on the document so it covers every slide without per-slide code.
onMounted(() => {
  document.addEventListener('click', (e) => {
    const v = e.target?.closest?.('.demo-stage video')
    if (!v) return
    if (document.fullscreenElement) document.exitFullscreen()
    else v.requestFullscreen?.()
  })
})
</script>

<template>
  <div v-if="!hidden" class="stage-corner">
    <StageMap size="sm" />
  </div>
</template>

<style scoped>
.stage-corner {
  position: absolute;
  top: 1.1rem;
  right: 1.6rem;
  z-index: 20;
  opacity: 0.75;
  transition: opacity .2s;
}
.stage-corner:hover { opacity: 1; }
</style>
