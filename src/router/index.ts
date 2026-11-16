import { createRouter, createWebHistory, type RouteRecordRaw } from 'vue-router'
import HomeView from '../views/HomeView.vue'

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

export default router
