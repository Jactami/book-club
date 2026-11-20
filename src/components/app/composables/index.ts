import { useI18n } from 'vue-i18n'
import type { NavItem } from '../types'

export function useNavItems() {
  const { t } = useI18n()

  const navItems: NavItem[] = [
    {
      id: 'home',
      label: t('nav.home.title'),
      href: '/',
      icon: 'home',
    },

    {
      id: 'vote',
      label: t('nav.vote.title'),
      href: '/vote',
      icon: 'vote',
    },
    {
      id: 'history',
      label: t('nav.history.title'),
      href: '/history',
      icon: 'history',
    },
  ]

  return navItems
}
