import { createRouter, createWebHistory, type RouteRecordRaw } from 'vue-router'
import HomeView from '../views/HomeView.vue'
import i18n from '@/i18n/index.ts'

const routes: RouteRecordRaw[] = [
  // HOME
  {
    path: '/',
    name: 'home',
    component: HomeView,
  },
  // PLAYGROUND
  {
    path: '/playground',
    name: 'playground',
    // route level code-splitting
    // this generates a separate chunk (About.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    component: () => import('../views/PlaygroundView.vue'),
    meta: {
      devOnly: true,
    },
  },
  // VOTE
  {
    path: '/vote',
    name: 'vote',
    component: () => import('../views/VoteView.vue'),
  },
  // HISTORY
  {
    path: '/history',
    name: 'history',
    component: () => import('../views/HistoryView.vue'),
  },
  // NOT FOUND
  {
    path: '/:pathMatch(.*)*',
    name: 'not-found',
    component: HomeView, // redirect to home
  },
]

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: import.meta.env.DEV ? routes : routes.filter((route) => !route.meta?.devOnly),
})

// Set page title
router.afterEach((to) => {
  const app = i18n.global.t('app.name')

  if (to.path === '/') {
    document.title = app
  } else {
    const page = i18n.global.t(`nav.${to.name?.toString()}.title`)
    document.title = `${page} | ${app}`
  }
})

export default router
