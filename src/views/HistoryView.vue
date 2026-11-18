<template>
  <UiHeading />

  <div>
    <ol class="grid grid-cols-2 gap-8 sm:grid-cols-3 lg:grid-cols-4 xl:grid-cols-5">
      <li v-for="item in history" :key="item.id" class="min-w-0">
        <!-- Cover -->
        <div
          class="border- flex aspect-2/3 items-center justify-center overflow-hidden rounded-default border-border bg-surface p-2"
        >
          <img
            :src="item.books.cover"
            :alt="`Cover - ${item.books.title}`"
            class="size-full object-contain"
            loading="lazy"
          />
        </div>

        <!-- Book information -->
        <h3 class="mt-2 line-clamp-2 text-lg font-semibold">
          {{ item.books.title }}
        </h3>

        <p class="line-clamp-1 text-text-muted">
          {{ item.books.authors.join(', ') }}
        </p>

        <div
          class="mt-3 size-fit rounded-full border border-border bg-surface-muted px-2 py-1 text-sm text-text-muted"
        >
          {{ d(item.date, { year: 'numeric', month: 'long' }) }}
        </div>
      </li>
    </ol>
  </div>
</template>

<script setup lang="ts">
import UiHeading from '@/components/ui/UiHeading.vue'
import { useDb } from '@/composables/db'
import { onMounted, ref } from 'vue'
import { useI18n } from 'vue-i18n'

const { d } = useI18n()
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
  console.log(data)
}
</script>
