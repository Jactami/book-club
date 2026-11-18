import { supabase } from '@/db'

function getHistory() {
  return supabase.from('history').select('*, books(*)')
}

export function useDb() {
  return {
    getHistory,
  }
}
