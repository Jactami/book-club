<template>
  <div class="min-h-screen sm:grid sm:grid-cols-[auto_1fr]">
    <AppNavigation />
    <div class="px-4 py-6 pbe-24 lg:px-10">
      <div class="mx-auto max-w-7xl">
        <RouterView />
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import AppNavigation from '@/components/app/AppNavigation.vue'
</script>
