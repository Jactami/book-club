<template>
  <UiCard variant="surface">
    <div class="flex items-center gap-x-6">
      <!-- Cover -->
      <BookCover :cover-url="book.cover_url" :title="book.title" class="h-40" />

      <!-- Book data -->
      <div>
        <h3 class="line-clamp-2 text-xl font-semibold hover:underline">
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
      <div class="flex flex-1 justify-end gap-x-2">
        <button
          v-for="point in pointOptions"
          :key="point"
          class="flex size-10 cursor-pointer items-center justify-center rounded-full border border-primary p-2 font-medium text-primary hover:bg-primary hover:text-on-primary active:scale-95"
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
