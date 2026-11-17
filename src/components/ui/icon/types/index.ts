import type { FunctionalComponent } from 'vue'
import MaterialSymbolsHistory2Rounded from '~icons/material-symbols/history-2-rounded'
import MaterialSymbolsHomeOutline from '~icons/material-symbols/home-outline'
import MaterialSymbolsHowToVoteOutlineRounded from '~icons/material-symbols/how-to-vote-outline-rounded'

export const icons = {
  // Navigation
  history: MaterialSymbolsHistory2Rounded,
  home: MaterialSymbolsHomeOutline,
  vote: MaterialSymbolsHowToVoteOutlineRounded,
} satisfies Record<string, FunctionalComponent>

export type Icon = keyof typeof icons
