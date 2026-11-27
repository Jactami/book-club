<template>
  <UiHeading />

  <UiSection title="Theme">
    <div
      class="flex flex-col gap-y-8 text-center text-sm [&>div]:flex [&>div>div]:flex [&>div>div]:size-20 [&>div>div]:items-center [&>div>div]:justify-center"
    >
      <div>
        <div class="bg-primary text-on-primary">Primary</div>
        <div class="bg-secondary text-on-secondary">Secondary</div>
      </div>
      <div>
        <div class="bg-surface">Surface</div>
        <div class="bg-surface-muted">Surface Muted</div>
      </div>
    </div>
  </UiSection>

  <UiSection title="Icons">
    <div class="grid grid-cols-12 justify-center gap-1">
      <template v-for="icon in Object.keys(icons)" :key="icon">
        <div class="flex flex-col items-center gap-y-0.5">
          <UiIcon :icon="icon as Icon" class="text-lg" />
          <span>{{ icon }}</span>
        </div>
      </template>
    </div>
  </UiSection>

  <UiSection title="Buttons">
    <div class="flex gap-2">
      <UiButton variant="solid" title="Solid Button">Solid Button</UiButton>
      <UiButton variant="outline" title="Outline Button">Outline Button</UiButton>
      <UiButton variant="solid" title="Disabled Button" disabled>Disabled Button</UiButton>
    </div>
  </UiSection>

  <UiSection title="Version">
    <pre>Version: {{ version }}</pre>
    <pre>Build Date: {{ buildDate }}</pre>
  </UiSection>
</template>

<script setup lang="ts">
import { icons, type Icon } from '@/components/ui/icon/types'
import UiIcon from '@/components/ui/icon/UiIcon.vue'
import UiButton from '@/components/ui/UiButton.vue'
import UiHeading from '@/components/ui/UiHeading.vue'
import UiSection from '@/components/ui/UiSection.vue'
import { useLogger } from '@/composables/log'

const version = __APP_VERSION__
const buildDate = __APP_BUILD_DATE__

const logger = useLogger('PlaygroundView.vue')
logger.info('Logger is running...')
</script>
