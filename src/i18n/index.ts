import { createI18n } from 'vue-i18n'
import de from './locales/de.json'

export default createI18n({
  legacy: false,
  availableLocales: ['de'],
  locale: 'de',
  messages: {
    de,
  },
})
