<template>
  <button
    v-if="auth.isAuthenticated"
    class="flex aspect-square h-full items-center justify-center rounded-full bg-primary p-2 text-on-primary"
    @click="signOut"
  >
    {{ auth.initials }}
  </button>
</template>

<script setup lang="ts">
import { useAuthStore } from '@/stores/auth'
import { useRouter } from 'vue-router'

const auth = useAuthStore()
const router = useRouter()

// TODO: Sign out on avatar click for the moment
async function signOut() {
  try {
    await auth.signOut()
    router.push({ path: '/' })
  } catch (error) {
    // TODO: Error handling
    console.error(error)
  }
}
</script>
