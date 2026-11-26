import type { Book } from '@/types'
import type { OpenLibraryResponse, OpenLibraryResult } from './types'

export async function searchOpenLibrary(title: string, author?: string) {
  // Base url from open library search api
  const url = new URL('https://openlibrary.org/search.json')

  // Set search parameters
  const params = new URLSearchParams({
    title,
    author: author || '',
    lang: 'de',
    fields:
      'key,title,author_name,first_publish_year,cover_i,editions,editions.key,editions.isbn,editions.cover_i',
    limit: '10',
  })

  url.search = params.toString()

  // Fetch data
  const response = await fetch(url)

  if (!response.ok) {
    throw new Error(`Error fetching data from Open Library: ${response.statusText}`)
  }

  const data: OpenLibraryResponse = await response.json()
  return data
}

export function normalizeOpenLibraryResult(result: OpenLibraryResult): Partial<Book> {
  // FIXME: Use first edition as best fit for now
  return {
    title: result.title,
    authors: result.author_name,
    cover_url: result.editions?.docs?.[0]?.cover_i
      ? `https://covers.openlibrary.org/b/id/${result.editions.docs[0].cover_i}-L.jpg`
      : undefined,
    isbn_10: result.editions?.docs?.[0]?.isbn?.find((isbn) => isbn.length === 10),
    isbn_13: result.editions?.docs?.[0]?.isbn?.find((isbn) => isbn.length === 13),
    page_count: result.number_of_pages_median,
    publication_year: result.first_publish_year,
    open_library_key: result.key,
  }
}
