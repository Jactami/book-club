import type { getHistory } from '@/composables/db'
import type { Tables } from '@/db/types/supabase'
import type { QueryData } from '@supabase/supabase-js'

// Atomic types
export type Profile = Tables<'profiles'>
export type Book = Tables<'books'>
export type History = Tables<'history'>

// Composite types
export type BookHistory = QueryData<ReturnType<typeof getHistory>>
