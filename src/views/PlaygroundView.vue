<template>
  <UiPage :title="t('nav.playground.title')" :subtitle="t('nav.playground.subtitle')">
    <UiSection title="Buch-Service">
      <button @click="fetchBooks">Suche Buch</button>
      <pre>Query: {{ query }}</pre>
      <img v-if="cover" :src="cover" alt="Buchcover" />
      <pre>{{ response }}</pre>
    </UiSection>

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
import { useBookService } from '@/composables/services/book'
import { ref } from 'vue'
import { useI18n } from 'vue-i18n'

const { t } = useI18n()

const version = __APP_VERSION__
const buildDate = __APP_BUILD_DATE__

const logger = useLogger('PlaygroundView.vue')
logger.info('Logger is running...')

const bookService = useBookService()
const query = ref<string>('faserland')
const response = ref<unknown>()
const cover = ref<string>()

async function fetchBooks() {
  response.value = await bookService.getBooks(query.value)
  // @ts-expect-error book service is not typed yet
  const coverId = response.value.data.docs[0].cover_i
  cover.value = bookService.getCover(coverId)
}
</script>
