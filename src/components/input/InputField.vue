<template>
  <div>
    <!-- Label -->
    <label :for="name" class="text-sm leading-6 font-medium">
      {{ label }}
    </label>

    <!-- Input -->
    <input
      :id="id"
      ref="inputEl"
      v-model="value"
      :type="type"
      :name="name"
      :class="[
        'mt-2 min-w-full appearance-none rounded-default bg-surface px-3.5 py-2 text-base shadow-sm -outline-offset-1',
        error
          ? 'outline-2 -outline-offset-2 outline-error placeholder:text-error'
          : 'outline-1 outline-border-strong placeholder:text-text-muted focus:outline-2 focus:-outline-offset-2 focus:outline-primary',
      ]"
      :placeholder="placeholder"
      :aria-describedby="describedById"
      :required="required"
      :autofocus="autofocus"
      :autocomplete="autocomplete"
      @keypress.enter="inputEl?.blur"
      @input="error ? validate() : undefined"
      @blur="validate"
    />
  </div>
</template>

<script setup lang="ts" generic="T">
import { computed, ref } from 'vue'

const props = defineProps<{
  id: string
  type: 'text' | 'email' | 'password' | 'number'
  name: string
  label: string
  placeholder?: string
  autocomplete?: string
  required?: boolean
  validation?: (value: T | undefined, ...args: unknown[]) => boolean
  autofocus?: boolean
}>()

const value = defineModel<T>()
const error = ref(false)

const inputEl = ref<HTMLInputElement | null>(null)

const describedById = computed(() => `${props.id}-description`)

// Validate value on user input
function validate() {
  if (props.required && !value.value) {
    error.value = true
  } else if (props.validation) {
    error.value = !props.validation(value.value)
  }
}
</script>
