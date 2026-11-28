<template>
  <form class="space-y-6" :actions="false" @submit.prevent="handleSignIn">
    <InputField
      id="email"
      v-model="email"
      type="email"
      name="email"
      :label="t('auth.email')"
      :placeholder="t('auth.email')"
      autocomplete="email"
      autofocus
      required
    />

    <InputField
      id="password"
      v-model="password"
      type="password"
      name="password"
      :label="t('auth.password')"
      :placeholder="t('auth.password')"
      required
    >
    </InputField>

    <div class="flex justify-center">
      <UiButton type="submit" class="w-full">
        {{ t('auth.signIn') }}
      </UiButton>
    </div>
  </form>
</template>

<script setup lang="ts">
import InputField from '@/components/input/InputField.vue'
import { ref } from 'vue'
import { useI18n } from 'vue-i18n'
import UiButton from '@/components/ui/UiButton.vue'
import { useAuthStore } from '@/stores/auth'
import { useRouter } from 'vue-router'

const { t } = useI18n()
const auth = useAuthStore()
const router = useRouter()

const email = ref('')
const password = ref('')

async function handleSignIn() {
  try {
    await auth.signIn(email.value, password.value)

    const target = router.currentRoute.value.query.redirect?.toString()
    router.push({ path: target ? target : '/' })
  } catch (error) {
    // TODO: Error handling
    console.error(error)
  }
}
</script>
