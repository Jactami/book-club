<template>
  <UiHeading />
</template>

<script setup lang="ts">
import UiHeading from '@/components/ui/UiHeading.vue'
import { useDb } from '@/composables/db'
import { useLogger } from '@/composables/log'
import type { ActiveVoting } from '@/types'
import { onMounted, ref } from 'vue'

const db = useDb()
const logger = useLogger()

const voting = ref<ActiveVoting>()

async function fetchActiveVoting() {
  const { data } = await db.getActiveVoting()
  if (data) {
    voting.value = data
  }

  logger.log(voting.value)
}

onMounted(() => {
  fetchActiveVoting()
})
</script>
