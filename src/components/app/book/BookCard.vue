<template>
  <a :href="`https://www.amazon.de/dp/${book.isbn_10}`" target="_blank" class="group">
    <!-- Cover -->
    <div
      class="mt-2 flex aspect-7/8 items-center justify-center rounded-default bg-surface-muted p-4 transition group-hover:shadow-md"
    >
      <img
        v-if="book.cover_url"
        :src="book.cover_url"
        :alt="book.title"
        loading="lazy"
        class="max-h-full max-w-full object-contain shadow-md transition group-hover:scale-105"
      />
    </div>

    <!-- Book Data -->
    <h3 class="mt-1 line-clamp-2 text-lg font-semibold group-hover:underline">{{ book.title }}</h3>
    <p class="line-clamp-1">{{ book.authors.join(', ') }}</p>

    <!-- Date -->
    <div class="mt-2 text-sm text-text-muted">
      {{ date }}
    </div>
  </a>
</template>

<script setup lang="ts">
import type { Book } from '@/types'
import { computed } from 'vue'
import { useI18n } from 'vue-i18n'

const props = defineProps<{
  book: Book
  date: Date
}>()

const { d } = useI18n()

const date = computed(() => d(props.date, { year: 'numeric', month: 'long' }))
</script>
