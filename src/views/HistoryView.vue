<template>
  <UiHeading />

  <div>
    <ol class="grid grid-cols-2 gap-8 sm:grid-cols-3 lg:grid-cols-4 2xl:grid-cols-5">
      <li v-for="item in history" :key="item.id" class="min-w-0">
        <BookCard :book="item.books" :date="item.date" />
      </li>
    </ol>
  </div>
</template>

<script setup lang="ts">
import BookCard from '@/components/app/book/BookCard.vue'
import UiHeading from '@/components/ui/UiHeading.vue'
import { useDb } from '@/composables/db'
import { onMounted, ref } from 'vue'

const db = useDb()

// TODO: Add type for history
// eslint-disable-next-line @typescript-eslint/no-explicit-any
const history = ref<any[]>()

onMounted(() => {
  fetchHistory()
})

async function fetchHistory() {
  const { data } = await db.getHistory()
  if (data) {
    history.value = data
  }
}
</script>
