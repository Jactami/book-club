<template>
  <div
    class="mt-2 flex aspect-7/8 items-center justify-center rounded-default bg-surface-muted p-4 transition group-hover:shadow-md"
  >
    <img
      v-if="coverUrl"
      :src="coverUrl"
      :alt="title ?? undefined"
      loading="lazy"
      class="max-h-full max-w-full object-contain shadow-md transition group-hover:scale-105"
    />
    <span v-else-if="title" class="text-muted text-center font-semibold">
      {{ title }}
    </span>
  </div>
</template>

<script setup lang="ts">
defineProps<{
  coverUrl: string | null
  title: string | null
}>()
</script>
