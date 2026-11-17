<template>
  <UiPage :title="t('nav.vote.title')" :subtitle="t('nav.vote.subtitle')"></UiPage>
</template>

<script setup lang="ts">
import UiPage from '@/components/ui/UiPage.vue'
import { useI18n } from 'vue-i18n'

const { t } = useI18n()
</script>
