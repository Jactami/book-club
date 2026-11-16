<template>
  <UiPage :title="t('nav.playground.title')" :subtitle="t('nav.playground.subtitle')">
    <UiSection title="Version">
      <pre>Version: {{ version }}</pre>
      <pre>Build Date: {{ buildDate }}</pre>
    </UiSection>
  </UiPage>
</template>

<script setup lang="ts">
import UiPage from '@/components/ui/UiPage.vue'
import UiSection from '@/components/ui/UiSection.vue'
import { useLogger } from '@/composables/log'
import { useI18n } from 'vue-i18n'

const { t } = useI18n()
const logger = useLogger('PlaygroundView.vue')

const version = __APP_VERSION__
const buildDate = __APP_BUILD_DATE__

logger.info('Logger is running...')
</script>
