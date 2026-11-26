import { useAsyncState } from '@vueuse/core'
import { normalizeOpenLibraryResult, searchOpenLibrary } from './open-library'
import { normalizeGoogleBooksResult, searchGoogleBooks } from './google-books'
import type { Book } from '@/types'

export function useBookService() {
  const searchBook = useAsyncState(
    async (title: string, author?: string) => {
      const [openLibraryResults, googleBooksResults] = await Promise.all([
        searchOpenLibrary(title, author),
        searchGoogleBooks(title, author),
      ])

      // FIXME: Just use first result for now
      return mergeBookSearchResults(
        openLibraryResults.docs?.[0]
          ? normalizeOpenLibraryResult(openLibraryResults.docs[0])
          : undefined,
        googleBooksResults.items?.[0]
          ? normalizeGoogleBooksResult(googleBooksResults.items[0])
          : undefined,
      )
    },
    null,
    { immediate: false },
  )

  return { ...searchBook }
}

function mergeBookSearchResults(
  openLibraryResults?: Partial<Book>,
  googleBooksResults?: Partial<Book>,
): Partial<Book> {
  // Pick the best of both worlds
  return {
    title: googleBooksResults?.title || openLibraryResults?.title,
    authors: googleBooksResults?.authors || openLibraryResults?.authors,
    cover_url: openLibraryResults?.cover_url || googleBooksResults?.cover_url,
    isbn_10: googleBooksResults?.isbn_10 || openLibraryResults?.isbn_10,
    isbn_13: googleBooksResults?.isbn_13 || openLibraryResults?.isbn_13,
    page_count: googleBooksResults?.page_count || openLibraryResults?.page_count,
    publication_year: googleBooksResults?.publication_year || openLibraryResults?.publication_year,
    google_books_key: googleBooksResults?.google_books_key,
    open_library_key: openLibraryResults?.open_library_key,
  }
}
