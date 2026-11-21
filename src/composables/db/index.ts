import { supabase } from '@/db'

export function getHistory() {
  return supabase.from('history').select('*, books(*)').order('period', { ascending: false })
}

export function getActiveVoting() {
  return supabase
    .from('voting_rounds')
    .select('*, proposals(*, books(*), votes(*), profiles(*))')
    .eq('is_open', true)
    .maybeSingle()
}

export function useDb() {
  return {
    getHistory,
    getActiveVoting,
  }
}
