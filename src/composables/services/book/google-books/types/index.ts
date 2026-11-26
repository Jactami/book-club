export interface GoogleBooksResponse {
  kind: string
  totalItems: number
  items?: GoogleBook[]
}

export interface GoogleBook {
  kind: string
  id: string
  etag: string
  selfLink: string
  volumeInfo: GoogleBookVolumeInfo
  saleInfo?: GoogleBookSaleInfo
  accessInfo?: GoogleBookAccessInfo
  searchInfo?: GoogleBookSearchInfo
}

export interface GoogleBookVolumeInfo {
  title: string
  subtitle?: string
  authors?: string[]
  publisher?: string
  publishedDate?: string
  description?: string
  industryIdentifiers?: GoogleBookIndustryIdentifier[]
  readingModes?: {
    text: boolean
    image: boolean
  }
  pageCount?: number
  printType?: string
  categories?: string[]
  averageRating?: number
  ratingsCount?: number
  maturityRating?: string
  allowAnonLogging?: boolean
  contentVersion?: string
  panelizationSummary?: {
    containsEpubBubbles: boolean
    containsImageBubbles: boolean
  }
  imageLinks?: {
    smallThumbnail?: string
    thumbnail?: string
    small?: string
    medium?: string
    large?: string
    extraLarge?: string
  }
  language?: string
  previewLink?: string
  infoLink?: string
  canonicalVolumeLink?: string
}

export interface GoogleBookIndustryIdentifier {
  type: string
  identifier: string
}

export interface GoogleBookSaleInfo {
  country: string
  saleability: string
  isEbook: boolean
  listPrice?: {
    amount: number
    currencyCode: string
  }
  retailPrice?: {
    amount: number
    currencyCode: string
  }
  buyLink?: string
}

export interface GoogleBookAccessInfo {
  country: string
  viewability: string
  embeddable: boolean
  publicDomain: boolean
  textToSpeechPermission: string
  epub?: {
    isAvailable: boolean
    downloadLink?: string
    acsTokenLink?: string
  }
  pdf?: {
    isAvailable: boolean
    downloadLink?: string
    acsTokenLink?: string
  }
  webReaderLink?: string
  accessViewStatus: string
  quoteSharingAllowed: boolean
}

export interface GoogleBookSearchInfo {
  textSnippet?: string
}
