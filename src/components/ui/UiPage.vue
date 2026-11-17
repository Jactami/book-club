<template>
  <div>
    <header class="mb-8 font-heading">
      <h1 class="text-4xl leading-tight font-bold text-pretty">{{ title }}</h1>
      <p v-if="subtitle" class="leading-tight text-pretty">{{ subtitle }}</p>
    </header>
    <main>
      <slot>
        <!-- Page content goes here... -->
      </slot>
    </main>
  </div>
</template>

<script setup lang="ts">
defineProps<{
  title: string
  subtitle?: string
}>()
</script>
