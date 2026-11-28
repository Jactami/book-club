import { supabase } from '@/db'

export function authService() {
  // Sign-In with credentials
  const signIn = async (email: string, password: string) => {
    const { data, error } = await supabase.auth.signInWithPassword({ email, password })
    if (error) throw error
    return data
  }

  // Sign-Out
  const signOut = async () => {
    const { error } = await supabase.auth.signOut()
    if (error) throw error
  }

  const getSession = async () => {
    const { data, error } = await supabase.auth.getSession()
    if (error) throw error
    return data.session
  }

  // Load user profile
  const loadProfile = async (userId: string) => {
    const { data, error } = await supabase.from('profiles').select().eq('id', userId).maybeSingle()
    if (error) throw error
    return data
  }

  return {
    signIn,
    signOut,
    getSession,
    loadProfile,
  }
}
