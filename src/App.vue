<template>
  <div class="flex min-h-screen flex-col">
    <!-- Header -->
    <AppHeader />

    <!-- Main Body -->
    <main class="container mx-auto flex flex-1 flex-col px-4 pt-6 pb-24 sm:pb-6 lg:px-10">
      <RouterView />
    </main>

    <!-- Footer -->
    <AppMobileNavigation />
  </div>
</template>

<script setup lang="ts">
import AppHeader from '@/components/app/AppHeader.vue'
import AppMobileNavigation from '@/components/app/AppMobileNavigation.vue'
</script>
