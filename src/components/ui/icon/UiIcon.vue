<template>
  <component :is="icons[icon]" :aria-label="label" :aria-hidden="!label" />
</template>

<script setup lang="ts">
import { icons, type Icon } from './types'

defineProps<{
  icon: Icon
  label?: string
}>()
</script>
