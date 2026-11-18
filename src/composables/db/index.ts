import { supabase } from '@/db'

function getHistory() {
  return supabase.from('history').select('*, books(*)').order('date', { ascending: false })
}

export function useDb() {
  return {
    getHistory,
  }
}
