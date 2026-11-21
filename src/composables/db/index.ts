import { supabase } from '@/db'

export function getHistory() {
  return supabase.from('history').select('*, books(*)').order('period', { ascending: false })
}

export function useDb() {
  return {
    getHistory,
  }
}
