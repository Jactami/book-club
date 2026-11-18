<template>
  <UiHeading />

  <UiSection title="Theme">
    <div
      class="flex flex-col gap-y-8 text-center text-sm [&>div]:flex [&>div>div]:flex [&>div>div]:size-20 [&>div>div]:items-center [&>div>div]:justify-center"
    >
      <div>
        <div class="bg-primary text-on-primary">Primary</div>
      </div>
      <div>
        <div class="bg-surface">Surface</div>
        <div class="bg-surface-muted">Surface Muted</div>
        <div class="bg-surface-accent text-primary">Surface Accent</div>
      </div>
    </div>
  </UiSection>

  <UiSection title="Icons">
    <div class="grid grid-cols-12 justify-center gap-1">
      <template v-for="icon in Object.keys(icons)" :key="icon">
        <div class="flex flex-col items-center gap-y-0.5">
          <UiIcon :icon="icon as Icon" class="text-lg" />
          <span>{{ icon }}</span>
        </div>
      </template>
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
</template>

<script setup lang="ts">
import { icons, type Icon } from '@/components/ui/icon/types'
import UiIcon from '@/components/ui/icon/UiIcon.vue'
import UiHeading from '@/components/ui/UiHeading.vue'
import UiSection from '@/components/ui/UiSection.vue'
import { useDb } from '@/composables/db'
import { useLogger } from '@/composables/log'
import { useBookService } from '@/composables/services/book'
import { onMounted, ref } from 'vue'

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

const db = useDb()

async function fetchHistory() {
  const { data } = await db.getHistory()
  logger.log('History', data)
}

onMounted(fetchHistory)
</script>
