<template>
  <div>
    <!-- Desktop -->
    <aside class="sticky top-0 hidden h-dvh w-72 bg-primary p-3 text-on-primary sm:block">
      <nav>
        <!-- Logo -->
        <div class="p-4 text-center font-heading text-2xl">
          <RouterLink to="/" class="flex flex-col items-center justify-center gap-1">
            <MaterialSymbolsLightMenuBookRounded class="text-7xl" aria-hidden="true" />
            <span>{{ t('app.name') }}</span>
          </RouterLink>
        </div>

        <!-- Navigation -->
        <ul class="mt-4 space-y-3 text-lg">
          <li v-for="item in navItems" :key="item.id">
            <RouterLink
              :to="item.href"
              class="flex items-center gap-x-1.5 rounded-default px-3 py-2 hover:bg-primary-hover"
              active-class="bg-primary-hover"
            >
              <UiIcon :icon="item.icon" :label="item.label" />
              <span>{{ item.label }} </span>
            </RouterLink>
          </li>
        </ul>
      </nav>
    </aside>

    <!-- Mobile -->
    <footer class="fixed bottom-0 z-50 w-screen bg-primary p-1 text-on-primary sm:hidden">
      <nav>
        <ul class="flex gap-x-1">
          <li v-for="item in navItems" :key="item.id" class="min-w-0 flex-1">
            <RouterLink
              :to="item.href"
              class="rounded-border hover:bg-surface-container-high flex flex-col items-center p-1.5"
              active-class="bg-surface-container-high"
            >
              <UiIcon :icon="item.icon" :label="item.label" />
              <span class="text-xs">{{ item.label }}</span>
            </RouterLink>
          </li>
        </ul>
      </nav>
    </footer>
  </div>
</template>

<script setup lang="ts">
import { useI18n } from 'vue-i18n'
import type { NavItem } from './types'
import MaterialSymbolsLightMenuBookRounded from '~icons/material-symbols-light/menu-book-rounded'
import UiIcon from '@/components/ui/icon/UiIcon.vue'

const { t } = useI18n()

const navItems: NavItem[] = [
  {
    id: 'home',
    label: t('nav.home.title'),
    href: '/',
    icon: 'home',
  },

  {
    id: 'vote',
    label: t('nav.vote.title'),
    href: '/vote',
    icon: 'vote',
  },
  {
    id: 'history',
    label: t('nav.history.title'),
    href: '/history',
    icon: 'history',
  },
]
</script>
