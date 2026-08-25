<script setup>
defineProps({
  href: { type: String, required: true },
  label: { type: String, required: true },
})
</script>

<template>
  <a class="demo-cta" :href="href" target="_blank" rel="noopener">
    <span class="demo-cta-label">{{ label }}</span>
    <span class="demo-cta-arrow">&#8599;</span>
  </a>
</template>

<style scoped>
.demo-cta {
  display: inline-flex;
  align-items: center;
  gap: 0.7rem;
  padding: 0.62rem 1.5rem;
  border: 2px solid var(--p-primary);
  border-radius: 999px;
  font-size: 1.28rem;
  font-weight: 600;
  line-height: 1;
  color: var(--p-primary);
  text-decoration: none;
  background: transparent;
  transition: background 0.15s ease, color 0.15s ease;
}
.demo-cta:hover {
  background: var(--p-primary);
  color: #fff;
}
.demo-cta-arrow {
  font-size: 1.05rem;
  opacity: 0.8;
}
</style>
