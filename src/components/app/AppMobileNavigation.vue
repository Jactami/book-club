<template>
  <footer class="fixed bottom-0 z-50 w-full border-t border-border bg-surface sm:hidden">
    <nav class="flex gap-x-1 p-1.5">
      <RouterLink
        v-for="item in navItems"
        :key="item.id"
        :to="item.href"
        class="flex-1 rounded-default text-sm hover:bg-primary hover:text-on-primary"
        active-class="bg-primary text-on-primary"
      >
        <div class="flex flex-col items-center justify-center gap-y-1 p-2">
          <UiIcon :icon="item.icon" :label="item.label" />
          <span>{{ item.label }}</span>
        </div>
      </RouterLink>
    </nav>
  </footer>
</template>

<script setup lang="ts">
import UiIcon from '@/components/ui/icon/UiIcon.vue'
import { useNavItems } from './composables'

const navItems = useNavItems()
</script>
