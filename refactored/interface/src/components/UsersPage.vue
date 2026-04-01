<template>
  <div class="container">
    <h1 class="title">Основні Таблиці</h1>

    <section class="tables-section">
      <div class="table-container" v-for="table in tables" :key="table.name">
        <h2 class="table-title">{{ table.title }}</h2>
        <table class="table">
          <thead>
            <tr>
              <th v-for="(column, index) in table.columns" :key="index">
                {{ column }}
              </th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="(row, rowIndex) in table.data" :key="rowIndex">
              <td v-for="(value, valueIndex) in row" :key="valueIndex">
                {{ value }}
              </td>
            </tr>
            <tr v-if="table.data.length === 0">
              <td colspan="100%">Немає даних</td>
            </tr>
          </tbody>
        </table>
      </div>
    </section>
  </div>
</template>

<script>
import axios from "axios";

export default {
  data() {
    return {
      tables: [
        {
          name: "Users",
          title: "Користувачі",
          columns: ["user_id", "username", "email", "created_at"],
          data: [],
        },
        {
          name: "Surveys",
          title: "Опитування",
          columns: ["survey_id", "title", "description", "created_at"],
          data: [],
        },
        {
          name: "Questions",
          title: "Питання",
          columns: [
            "question_id",
            "survey_id",
            "question_text",
            "question_type",
          ],
          data: [],
        },
        {
          name: "Responses",
          title: "Відповіді",
          columns: ["response_id", "survey_id", "user_id", "submitted_at"],
          data: [],
        },
        {
          name: "UserAnswers",
          title: "Відповіді Користувачів",
          columns: [
            "user_answer_id",
            "response_id",
            "answer_id",
            "text_answer",
          ],
          data: [],
        },
      ],
    };
  },
  mounted() {
    this.fetchData();
  },
  methods: {
    async fetchData() {
      for (const table of this.tables) {
        try {
          const response = await axios.get(
            `http://localhost:3000/${table.name}`
          );
          table.data = response.data;
        } catch (error) {
          console.error(`Error fetching data for ${table.name}:`, error);
        }
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

.tables-section {
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.table-container {
  border: 1px solid #ccc;
  border-radius: 8px;
  overflow: hidden;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.table-title {
  background-color: #f0f0f0;
  padding: 10px;
  font-size: 1.5rem;
  text-align: center;
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
