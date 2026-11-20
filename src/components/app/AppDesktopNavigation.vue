<template>
  <nav class="hidden items-center justify-center gap-x-1 sm:flex">
    <RouterLink
      v-for="item in navItems"
      :key="item.id"
      :to="item.href"
      class="rounded-full px-4 py-1.5 hover:bg-primary hover:text-on-primary"
      active-class="bg-primary text-on-primary"
    >
      {{ item.label }}
    </RouterLink>
  </nav>
</template>

<script setup lang="ts">
import { useNavItems } from './composables'

const navItems = useNavItems()
</script>
