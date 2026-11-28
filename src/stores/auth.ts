import { supabase } from '@/db'
import { authService } from '@/services/auth'
import type { Profile } from '@/types'
import type { Session } from '@supabase/supabase-js'
import { defineStore } from 'pinia'
import { computed, ref } from 'vue'

export const useAuthStore = defineStore('auth', () => {
  // State
  const session = ref<Session | null>(null)
  const profile = ref<Profile | null>(null)

  const loading = ref(false)
  const error = ref<string | null>(null)
  const initialized = ref(false)

  // Getters
  const isAuthenticated = computed(() => !!user.value)
  const user = computed(() => session.value?.user ?? null)
  const firstName = computed(() => profile.value?.first_name)
  const lastName = computed(() => profile.value?.last_name)
  const initials = computed(() =>
    profile.value ? `${firstName.value?.[0]}${lastName.value?.[0]}` : null,
  )

  // Actions
  const signIn = async (email: string, password: string) => {
    loading.value = true
    error.value = null

    try {
      const data = await authService().signIn(email, password)
      await loadProfile(data.user.id)
      // Listener will set user and session data
    } catch (err) {
      error.value = err instanceof Error ? err.message : String(err)
      throw err
    } finally {
      loading.value = false
    }
  }

  const signOut = async () => {
    loading.value = true
    error.value = null

    try {
      await authService().signOut()
      // Listener will clean session and profile data
    } catch (err) {
      error.value = err instanceof Error ? err.message : String(err)
      throw err
    } finally {
      loading.value = false
    }
  }

  const loadProfile = async (userId: string) => {
    loading.value = true
    error.value = null

    try {
      const data = await authService().loadProfile(userId)

      if (user.value?.id === userId) profile.value = data
    } catch (err) {
      error.value = err instanceof Error ? err.message : String(err)
      throw err
    } finally {
      loading.value = false
    }
  }

  const init = async () => {
    if (initialized.value) return

    // Init auth listener
    supabase.auth.onAuthStateChange((_, sessionData) => {
      session.value = sessionData

      // Clean profile data if user is signed out
      if (!user.value) {
        profile.value = null
        return
      }

      // Otherwise, load the profile data
      loadProfile(user.value.id)
    })

    // Load initial session and user data
    loading.value = true
    error.value = null

    try {
      session.value = await authService().getSession()

      if (user.value) {
        await loadProfile(user.value.id)
      }

      initialized.value = true
    } catch (err) {
      error.value = err instanceof Error ? err.message : String(err)
      throw err
    } finally {
      loading.value = false
    }
  }

  return {
    user,
    session,
    profile,
    loading,
    error,
    isAuthenticated,
    firstName,
    lastName,
    initials,
    init,
    signIn,
    signOut,
  }
})
