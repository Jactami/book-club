import { supabase } from '@/db'

function getHistory() {
  return supabase.from('history').select('*, books(*)').order('period', { ascending: false })
}

export function useDb() {
  return {
    getHistory,
  }
}
