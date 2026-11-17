<template>
  <UiPage :title="t('nav.playground.title')" :subtitle="t('nav.playground.subtitle')">
    <UiSection title="Theme">
      <div
        class="flex flex-col gap-y-8 text-center text-sm [&>div]:flex [&>div>div]:flex [&>div>div]:size-20 [&>div>div]:items-center [&>div>div]:justify-center"
      >
        <div>
          <div class="bg-primary text-on-primary">Primary</div>
          <div class="bg-primary-container text-on-primary-container">Primary Container</div>
          <div class="bg-secondary text-on-secondary">Secondary</div>
          <div class="bg-secondary-container text-on-secondary-container">Secondary Container</div>

          <div class="bg-tertiary text-on-tertiary">Tertiary</div>
          <div class="bg-tertiary-container text-on-tertiary-container">Tertiary Container</div>
        </div>
        <div>
          <div class="bg-surface-container-lowest text-on-surface">Container lowest</div>
          <div class="bg-surface-container-low text-on-surface">Container low</div>
          <div class="bg-surface-container text-on-surface">Container</div>
          <div class="bg-surface-container-high text-on-surface">Container high</div>
          <div class="bg-surface-container-highest text-on-surface">Container highest</div>
        </div>
        <div>
          <div class="bg-success text-on-success">Success</div>
          <div class="bg-success-container text-on-success-container">Success Container</div>
          <div class="bg-warning text-on-warning">Warning</div>
          <div class="bg-warning-container text-on-warning-container">Warning Container</div>
          <div class="bg-error text-on-error">Error</div>
          <div class="bg-error-container text-on-error-container">Error Container</div>
        </div>
      </div>
    </UiSection>

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
import { supabase } from '@/db'
import { onMounted, ref } from 'vue'
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

onMounted(async () => {
  const { data } = await supabase.from('books').select()
  console.log(data)
})
</script>
