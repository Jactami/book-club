<template>
  <UiHeading />

  <div class="grid grid-cols-1 gap-4 sm:grid-cols-3">
    <div class="order-last flex flex-col gap-2 sm:order-first sm:col-span-2">
      <!-- Book proposals -->
      <VoteCard
        v-for="proposal in voting?.proposals"
        :key="proposal.id"
        :book="proposal.books"
        :votes="proposal.votes"
        :proposedBy="proposal.profiles"
        @vote="handleVote(proposal.id, $event)"
      />
    </div>

    <div>
      <!-- Book Search TODO: Custom Components + layout -->
      <UiCard variant="surface">
        <form :action="undefined" @submit.prevent="fetchBook" class="flex flex-col gap-2">
          <input
            v-model="bookTitle"
            type="text"
            placeholder="TODO: Buchtitel"
            class="rounded-default border border-border-strong p-2"
          />
          <input
            v-model="bookAuthor"
            type="text"
            placeholder="TODO: Autor:in"
            class="rounded-default border border-border-strong p-2"
          />
          <button type="submit" class="rounded-default bg-primary p-2 text-on-primary">
            Suchen
          </button>
        </form>
      </UiCard>
    </div>
  </div>
</template>

<script setup lang="ts">
import UiCard from '@/components/ui/UiCard.vue'
import UiHeading from '@/components/ui/UiHeading.vue'
import VoteCard from '@/components/vote/VoteCard.vue'
import { useDb } from '@/composables/db'
import { useLogger } from '@/composables/log'
import { useBookService } from '@/composables/services/book'
import type { VoteResult } from '@/types'
import { onMounted, ref } from 'vue'

const db = useDb()
const logger = useLogger('VoteView.vue')

const voting = ref<VoteResult>()

async function fetchActiveVoting() {
  const { data } = await db.getActiveVoting()
  if (data) {
    voting.value = data
  }
}

function handleVote(proposalId: string, points: number) {
  logger.info(`Voted with ${points} points for proposal ${proposalId}`)
}

onMounted(() => {
  fetchActiveVoting()
})

const bookTitle = ref('')
const bookAuthor = ref('')

const { state, executeImmediate } = useBookService()

async function fetchBook() {
  await executeImmediate(bookTitle.value, bookAuthor.value)
  logger.info('Book search executed', state.value)
}
</script>
