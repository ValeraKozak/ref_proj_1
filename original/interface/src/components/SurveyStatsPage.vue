<template>
  <div class="container">
    <h1 class="title">Статистика Опитувань</h1>
    <table class="table">
      <thead>
        <tr>
          <th>ID Опитування</th>
          <th>Назва</th>
          <th>Опис</th>
          <th>Статус</th>
          <th>Кількість Питань</th>
          <th>Кількість Відповідей</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="survey in surveys" :key="survey.survey_id">
          <td>{{ survey.survey_id }}</td>
          <td>{{ survey.survey_title }}</td>
          <td>{{ survey.survey_description }}</td>
          <td>{{ survey.survey_status }}</td>
          <td>{{ survey.total_questions }}</td>
          <td>{{ survey.total_responses }}</td>
        </tr>
        <tr v-if="surveys.length === 0">
          <td colspan="6">Немає даних</td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
import axios from "axios";

export default {
  data() {
    return {
      surveys: [],
    };
  },
  mounted() {
    this.fetchSurveyStatistics();
  },
  methods: {
    async fetchSurveyStatistics() {
      try {
        const response = await axios.get(
          "http://localhost:3000/survey-statistics"
        );
        this.surveys = response.data[0];
      } catch (error) {
        console.error("Error fetching survey statistics:", error);
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

.table {
  width: 100%;
  border-collapse: collapse;
  margin-top: 20px;
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
