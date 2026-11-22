<template>
  <div
    :class="[
      'rounded-default border border-border p-4',
      { 'bg-surface': variant === 'surface' },
      { 'bg-surface-muted': variant === 'muted' },
    ]"
  >
    <div class="overflow-hidden">
      <slot>
        <!-- Card content goes here... -->
      </slot>
    </div>
  </div>
</template>

<script setup lang="ts">
defineProps<{
  variant?: 'surface' | 'muted'
}>()
</script>
