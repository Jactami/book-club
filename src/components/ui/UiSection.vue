<template>
  <section class="py-8">
    <header v-if="title || subtitle" class="mb-8 font-heading">
      <h2 v-if="title" class="text-2xl leading-tight font-bold text-pretty">{{ title }}</h2>
      <p v-if="subtitle" class="text-pretty">{{ subtitle }}</p>
    </header>
    <div>
      <slot>
        <!-- Section content goes here... -->
      </slot>
    </div>
  </section>
</template>

<script setup lang="ts">
defineProps<{
  title?: string
  subtitle?: string
}>()
</script>
