import { createRouter, createWebHistory } from "vue-router";
import HomePage from "./components/Homepage/HomePage.vue";
import GameScreen from "./components/Game/GameScreen.vue";

const routes = [
  { path: "/", component: HomePage },
  { path: "/game/:artist", component: GameScreen, props: true },
];

export default createRouter({
  history: createWebHistory(),
  routes,
});
