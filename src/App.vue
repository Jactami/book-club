<template>
  <div class="min-h-screen">
    <!-- Header -->
    <AppHeader />

    <!-- Main Body -->
    <div class="container mx-auto px-4 pt-6 pb-24 sm:pb-6 lg:px-10">
      <main>
        <RouterView />
      </main>
    </div>

    <!-- Footer -->
    <AppMobileNavigation />
  </div>
</template>

<script setup lang="ts">
import AppHeader from '@/components/app/AppHeader.vue'
import AppMobileNavigation from '@/components/app/AppMobileNavigation.vue'
</script>
