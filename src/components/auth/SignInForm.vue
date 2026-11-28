<template>
  <form class="space-y-6" :actions="false" @submit.prevent="handleLogin">
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
import { useLogger } from '@/composables/log'
import { ref } from 'vue'
import { useI18n } from 'vue-i18n'
import UiButton from '@/components/ui/UiButton.vue'

const { t } = useI18n()

const email = ref('')
const password = ref('')

function handleLogin() {
  useLogger().log('handleLogin', { email: email.value, password: password.value })
}
</script>
