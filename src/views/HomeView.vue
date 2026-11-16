<template>
  <main>
    <pre>Hello World</pre>
    <p class="text-blue-500">Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
    <pre>{{ t('test') }}</pre>
    <pre>Version: {{ version }}</pre>
    <pre>Build Date: {{ buildDate }}</pre>
    <MaterialSymbolsBookRibbonRounded class="h-6 w-6 text-red-500" />
  </main>
</template>

<script setup lang="ts">
import { useI18n } from 'vue-i18n'
import MaterialSymbolsBookRibbonRounded from '~icons/material-symbols/book-ribbon-rounded'

const { t } = useI18n()

const version = __APP_VERSION__
const buildDate = __APP_BUILD_DATE__
</script>
