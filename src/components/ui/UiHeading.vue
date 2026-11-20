<template>
  <header class="my-4">
    <h1 class="text-3xl leading-tight font-bold text-pretty sm:text-4xl">{{ title }}</h1>
    <p v-if="subtitle" class="text-lg leading-tight text-pretty text-text-muted">
      {{ subtitle }}
    </p>
  </header>
</template>

<script setup lang="ts">
import { computed } from 'vue'
import { useI18n } from 'vue-i18n'
import { useRoute } from 'vue-router'

const { t } = useI18n()
const route = useRoute()

// Compute heading based on current route
const title = computed(() => t(`nav.${route.name?.toString()}.title`))
const subtitle = computed(() => t(`nav.${route.name?.toString()}.subtitle`))
</script>
