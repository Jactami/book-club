<template>
  <header
    class="z-50 w-full border-b border-border bg-background/80 shadow-sm backdrop-blur-sm sm:sticky sm:top-0"
  >
    <div class="flex items-center justify-between gap-x-4 px-4 py-2.5 sm:px-8 sm:py-4">
      <!-- Title -->
      <RouterLink to="/">
        <h1 class="text-lg font-bold sm:text-2xl">{{ t('app.name') }}</h1>
      </RouterLink>

      <!-- Desktop Navigation -->
      <AppDesktopNavigation class="ml-auto" />

      <!-- TODO: User Avatar -->
      <div
        class="flex aspect-square h-full items-center justify-center rounded-full bg-orange-500 p-1.5"
      >
        <span class="text-white">JD</span>
      </div>
    </div>
  </header>
</template>

<script setup lang="ts">
import { useI18n } from 'vue-i18n'
import AppDesktopNavigation from './AppDesktopNavigation.vue'

const { t } = useI18n()
</script>
