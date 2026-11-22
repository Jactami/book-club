<template>
  <div
    :class="[
      'rounded-default border border-border p-4',
      { 'bg-surface': variant === 'surface' },
      { 'bg-surface-muted': variant === 'muted' },
    ]"
  >
    <slot>
      <!-- Card content goes here... -->
    </slot>
  </div>
</template>

<script setup lang="ts">
defineProps<{
  variant?: 'surface' | 'muted'
}>()
</script>
