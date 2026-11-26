import type { Book } from '@/types'
import type { GoogleBook, GoogleBooksResponse } from './types'

export async function searchGoogleBooks(title: string, author?: string) {
  // Base url from google books  api
  const url = new URL('https://www.googleapis.com/books/v1/volumes')

  // Set search parameters
  const params = new URLSearchParams({
    q: `intitle:${title}${author ? `+inauthor:${author}` : ''}`,
    printType: 'books',
    maxResults: '10',
    key: import.meta.env.VITE_GOOGLE_BOOKS_API_KEY,
  })

  url.search = params.toString()

  // Fetch data
  const response = await fetch(url)

  if (!response.ok) {
    throw new Error(`Error fetching data from Google Books: ${response.statusText}`)
  }

  const data: GoogleBooksResponse = await response.json()
  return data
}

export function normalizeGoogleBooksResult(result: GoogleBook): Partial<Book> {
  return {
    title: result.volumeInfo.title,
    authors: result.volumeInfo.authors,
    cover_url: result.volumeInfo.imageLinks?.large || result.volumeInfo.imageLinks?.thumbnail,
    isbn_10: result.volumeInfo.industryIdentifiers?.find((id) => id.type === 'ISBN_10')?.identifier,
    isbn_13: result.volumeInfo.industryIdentifiers?.find((id) => id.type === 'ISBN_13')?.identifier,
    page_count: result.volumeInfo.pageCount,
    publication_year: result.volumeInfo.publishedDate
      ? parseInt(result.volumeInfo.publishedDate)
      : undefined,
    google_books_key: result.id,
  }
}
