<template>
  <button
    :type="type"
    :class="buttonClasses"
    :title="title"
    :aria-label="title"
    :disabled="disabled"
  >
    <slot>
      <!-- Button content goes here... -->
    </slot>
  </button>
</template>

<script setup lang="ts">
import { twMerge } from 'tailwind-merge'
import { computed } from 'vue'

interface ButtonProps {
  // TODO: Add severity class (primary, secondary, neutral, etc.)?
  variant?: 'solid' | 'outline'
  type?: 'button' | 'submit' | 'reset'
  disabled?: boolean
  title?: string
}

const props = withDefaults(defineProps<ButtonProps>(), {
  variant: 'solid',
  type: 'button',
  disabled: false,
})

const variantClasses: Record<NonNullable<ButtonProps['variant']>, string> = {
  solid: `bg-primary text-on-primary `,
  outline: 'text-primary border border-primary',
}

// TODO: Decide whether a 'transition active:scale-95' should be added to base classes.
const buttonClasses = computed(() =>
  twMerge([
    // Base
    'relative inline-flex cursor-pointer transition font-medium items-center justify-center gap-x-1 px-3 py-2 text-sm sm:text-base',
    // Shape
    'rounded-default',
    // Focus
    'focus:outline-none focus-visible-ring-primary focus-visible:ring-2 focus-visible:ring-offset-2',
    // Hover
    'enabled:hover:scale-105 enabled:hover:shadow-md',
    // Active
    'enabled:active:scale-95',
    // Disabled
    'disabled:cursor-not-allowed disabled:opacity-50',
    // Shadow
    'shadow-sm disabled:shadow-none',
    // Variant classes
    variantClasses[props.variant],
  ]),
)
</script>
