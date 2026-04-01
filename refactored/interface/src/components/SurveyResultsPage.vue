<template>
  <div class="container">
    <h1 class="title">Статистика Користувачів</h1>

    <section class="table-section">
      <h2 class="section-title">Покращення Відповідей Користувачів</h2>
      <table class="table">
        <thead>
          <tr>
            <th>Ім'я Користувача</th>
            <th>Відповідь</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="userAnswer in userAnswers" :key="userAnswer.username">
            <td>{{ userAnswer.username }}</td>
            <td>{{ userAnswer.text_answer }}</td>
          </tr>
          <tr v-if="userAnswers.length === 0">
            <td colspan="2">Немає даних</td>
          </tr>
        </tbody>
      </table>
    </section>

    <section class="table-section">
      <h2 class="section-title">
        Користувач з Найбільшим Кількістю Завершених Опитувань
      </h2>
      <table class="table">
        <thead>
          <tr>
            <th>Ім'я Користувача</th>
            <th>Завершені Опитування</th>
          </tr>
        </thead>
        <tbody>
          <tr v-if="topSurveyCompleter">
            <td>{{ topSurveyCompleter.username }}</td>
            <td>{{ topSurveyCompleter.total_surveys }}</td>
          </tr>
          <tr v-else>
            <td colspan="2">Немає даних</td>
          </tr>
        </tbody>
      </table>
    </section>
  </div>
</template>

<script>
import axios from "axios";

export default {
  data() {
    return {
      userAnswers: [],
      topSurveyCompleter: null,
    };
  },
  mounted() {
    this.fetchUserAnswers();
    this.fetchTopSurveyCompleter();
  },
  methods: {
    async fetchUserAnswers() {
      try {
        const response = await axios.get(
          "http://localhost:3000/user-answers/improve"
        );
        this.userAnswers = response.data;
      } catch (error) {
        console.error("Error fetching user answers:", error);
      }
    },
    async fetchTopSurveyCompleter() {
      try {
        const response = await axios.get(
          "http://localhost:3000/users/top-survey-completer"
        );
        this.topSurveyCompleter = response.data[0];
      } catch (error) {
        console.error("Error fetching top survey completer:", error);
      }
    },
  },
};
</script>

<style scoped>
.container {
  padding: 20px;
  max-width: 1200px;
  margin: auto;
}

.title {
  text-align: center;
  font-size: 2rem;
  margin-bottom: 20px;
}

.table-section {
  margin-bottom: 30px;
  border: 1px solid #ccc;
  border-radius: 8px;
  overflow: hidden;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.section-title {
  background-color: #f0f0f0;
  padding: 10px;
  font-size: 1.5rem;
  text-align: center;
  margin: 0;
}

.table {
  width: 100%;
  border-collapse: collapse;
}

.table th,
.table td {
  padding: 10px;
  border: 1px solid #ddd;
  text-align: left;
}

.table th {
  background-color: #f9f9f9;
}

.table tr:nth-child(even) {
  background-color: #f2f2f2;
}

.table tr:hover {
  background-color: #f1f1f1;
}
</style>
