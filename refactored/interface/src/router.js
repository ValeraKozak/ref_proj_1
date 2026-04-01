import { createRouter, createWebHashHistory } from "vue-router";
import UsersPage from "@/components/UsersPage.vue";
import SurveyResultsPage from "@/components/SurveyResultsPage.vue";
import SurveyStatsPage from "@/components/SurveyStatsPage.vue";

export default createRouter({
  history: createWebHashHistory(),
  routes: [
    { path: "/users", component: UsersPage },
    { path: "/survey-results", component: SurveyResultsPage },
    { path: "/survey-stats", component: SurveyStatsPage },
  ],
});
