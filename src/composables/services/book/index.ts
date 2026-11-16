import { useFetch } from '@vueuse/core'

export function useBookService() {
  const getBooks = (query: string) => {
    const fields = [
      'key',
      'title',
      'author_name',
      'first_publish_year',
      'cover_i',
      'editions',
      'editions.key',
      'editions.isbn',
      'editions.cover_i',
    ]
    const url = `https://openlibrary.org/search.json?q=${query}&lang=de&fields=${fields.join(',')}`
    return useFetch<unknown>(url).get().json() // TODO: Type response data
  }

  const getCover = (coverId: string) => {
    return `https://covers.openlibrary.org/b/id/${coverId}-L.jpg`
  }

  return {
    getBooks,
    getCover,
  }
}
