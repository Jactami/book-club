<template>
  <UiCard variant="surface">
    <div class="sm:flex-no-wrap flex flex-wrap items-center gap-3 sm:gap-6">
      <!-- Cover -->
      <BookCover :cover-url="book.cover_url" :title="book.title" class="h-28 sm:h-40" />

      <!-- Book data -->
      <div class="flex-1">
        <h3 class="line-clamp-2 text-lg font-semibold hyphens-auto hover:underline sm:text-xl">
          <a
            :href="`https://www.amazon.de/dp/${book.isbn_10}`"
            target="_blank"
            rel="noopener noreferrer"
          >
            {{ book.title }}
          </a>
        </h3>
        <p class="line-clamp-1">{{ book.authors.join(', ') }}</p>
        <!-- TODO: Add i18n -->
        <p class="mt-2 text-sm text-text-muted">
          von {{ proposedBy.first_name }} {{ proposedBy.last_name }}
        </p>
      </div>

      <!-- Voting -->
      <div class="flex w-full gap-x-2 sm:w-fit">
        <button
          v-for="point in pointOptions"
          :key="point"
          class="flex size-10 flex-1 cursor-pointer items-center justify-center rounded-default border border-primary p-2 font-medium text-primary hover:bg-primary hover:text-on-primary active:scale-95 sm:rounded-full"
          @click="emit('vote', point)"
        >
          {{ point }}
        </button>
      </div>
    </div>
  </UiCard>
</template>

<script setup lang="ts">
import type { Book, Profile, Vote } from '@/types'
import UiCard from '@/components/ui/UiCard.vue'
import BookCover from '@/components/book/BookCover.vue'

defineProps<{
  book: Book
  votes: Vote[]
  proposedBy: Profile
}>()

const emit = defineEmits<{
  (e: 'vote', points: number): void
}>()

// TODO: Fixed points for now
const maxPoints = 3
const pointOptions = Array.from({ length: maxPoints }, (_, i) => i + 1)
</script>
