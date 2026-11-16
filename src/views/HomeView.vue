<template>
  <main>
    <pre>Hello World</pre>
    <p class="text-blue-500">Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
    <pre>{{ t('test') }}</pre>
  </main>
</template>

<script setup lang="ts">
import { useI18n } from 'vue-i18n'

const { t } = useI18n()

console.log('Hello World')
</script>
