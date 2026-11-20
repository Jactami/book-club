<template>
  <UiHeading />

  <div>
    <div v-if="years.length > 1" class="mb-4 flex gap-2">
      <!-- TODO: Turn this into a button/ pill component? -->
      <button
        v-for="year in years"
        :key="year"
        :class="[
          'cursor-pointer rounded-full border px-4 py-1.5 transition-all hover:bg-primary hover:text-on-primary active:scale-95',
          {
            'border-border bg-surface': selectedYear !== year,
            'border-primary bg-primary text-on-primary': selectedYear === year,
          },
        ]"
        @click="selectYear(year)"
      >
        {{ year }}
      </button>
    </div>

    <ol class="grid grid-cols-2 gap-8 sm:grid-cols-3 lg:grid-cols-4 2xl:grid-cols-5">
      <li v-for="item in selectedHistory" :key="item.id" class="min-w-0">
        <BookCard :book="item.books" :date="new Date(item.date)" />
      </li>
    </ol>
  </div>
</template>

<script setup lang="ts">
import BookCard from '@/components/app/book/BookCard.vue'
import UiHeading from '@/components/ui/UiHeading.vue'
import { useDb } from '@/composables/db'
import { computed, onMounted, ref } from 'vue'

const db = useDb()

// TODO: Add type for history
// eslint-disable-next-line @typescript-eslint/no-explicit-any
const history = ref<any[]>()
const selectedYear = ref<number | null>(null)

const selectedHistory = computed(() => {
  if (!selectedYear.value) return history.value

  return history.value?.filter((item) => {
    const year = new Date(item.date).getFullYear()
    return year === selectedYear.value
  })
})

const years = computed(() => {
  const yearSet = new Set<number>()
  history.value?.forEach((item) => {
    const year = new Date(item.date).getFullYear()
    yearSet.add(year)
  })

  return Array.from(yearSet).sort((yearA, yearB) => yearB - yearA)
})

onMounted(() => {
  fetchHistory()
})

async function fetchHistory() {
  const { data } = await db.getHistory()
  if (data) {
    history.value = data
  }
}

function selectYear(year: number) {
  selectedYear.value = selectedYear.value === year ? null : year
}
</script>
