<template>
  <a
    :href="`https://www.amazon.de/dp/${book.isbn_10}`"
    target="_blank"
    rel="noopener noreferrer"
    class="group"
  >
    <!-- Cover -->
    <BookCover :cover-url="book.cover_url" :title="book.title" />

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
import BookCover from './BookCover.vue'

const props = defineProps<{
  book: Book
  date: Date
}>()

const { d } = useI18n()

const date = computed(() => d(props.date, { year: 'numeric', month: 'long' }))
</script>
