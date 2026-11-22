<template>
  <UiHeading />

  <div class="grid grid-cols-1 gap-4 sm:grid-cols-3">
    <div class="flex flex-col gap-2 sm:col-span-2">
      <!-- Book proposals -->
      <UiCard v-for="proposal in voting?.proposals" :key="proposal.id" variant="surface">
        <div class="flex items-center gap-x-2">
          <BookCover
            :cover-url="proposal.books.cover_url"
            :title="proposal.books.title"
            class="h-40"
          />
          <div>
            <h3 class="line-clamp-2 text-xl font-semibold hover:underline">
              <a
                :href="`https://www.amazon.de/dp/${proposal.books.isbn_10}`"
                target="_blank"
                rel="noopener noreferrer"
              >
                {{ proposal.books.title }}
              </a>
            </h3>
            <p class="line-clamp-1">{{ proposal.books.authors.join(', ') }}</p>
            <!-- TODO: Add i18n -->
            <p class="mt-2 text-sm text-text-muted">
              von {{ proposal.profiles.first_name }} {{ proposal.profiles.last_name }}
            </p>
          </div>
        </div>
      </UiCard>
    </div>

    <div>
      <UiCard variant="surface">
        <span>Placeholder</span>
      </UiCard>
    </div>
  </div>
</template>

<script setup lang="ts">
import BookCover from '@/components/book/BookCover.vue'
import UiCard from '@/components/ui/UiCard.vue'
import UiHeading from '@/components/ui/UiHeading.vue'
import { useDb } from '@/composables/db'
import type { VoteResult } from '@/types'
import { onMounted, ref } from 'vue'

const db = useDb()

const voting = ref<VoteResult>()

async function fetchActiveVoting() {
  const { data } = await db.getActiveVoting()
  if (data) {
    voting.value = data
  }
}

onMounted(() => {
  fetchActiveVoting()
})
</script>
