const express = require("express");
const mysql = require("mysql2/promise");
const bodyParser = require("body-parser");
const cors = require("cors");

const app = express();
const port = 3000;

const config = {
  host: "127.0.0.1",
  user: "root",
  password: "password",
  database: "OnlineSurveys",
};

app.use(bodyParser.json());
app.use(cors());
async function queryDatabase(query, params = []) {
  let connection;
  try {
    connection = await mysql.createConnection(config);
    const [results] = await connection.execute(query, params);
    return results;
  } catch (err) {
    console.error("Error querying database:", err);
    throw err;
  } finally {
    if (connection) {
      await connection.end();
    }
  }
}

app.get("/user-answers/improve", async (req, res) => {
  const query = `
      SELECT DISTINCT Users.username, UserAnswers.text_answer
      FROM Users
      JOIN Responses ON Users.user_id = Responses.user_id
      JOIN UserAnswers ON Responses.response_id = UserAnswers.response_id
      WHERE UserAnswers.text_answer LIKE '%покращити%';
  `;
  try {
    const result = await queryDatabase(query);
    res.send(result);
  } catch (error) {
    res.status(500).send("Error fetching data");
  }
});

app.get("/users/top-survey-completer", async (req, res) => {
  const query = `
      SELECT Users.username, COUNT(Responses.response_id) AS total_surveys
      FROM Users
      JOIN Responses ON Users.user_id = Responses.user_id
      GROUP BY Users.username
      ORDER BY total_surveys DESC
      LIMIT 1;
  `;
  try {
    const result = await queryDatabase(query);
    res.send(result);
  } catch (error) {
    res.status(500).send("Error fetching data");
  }
});

app.get("/survey-statistics", async (req, res) => {
  const query = `CALL GetSurveyStatistics();`;
  try {
      const result = await queryDatabase(query);
      res.send(result);
  } catch (error) {
      console.error("Error fetching survey statistics:", error);
      res.status(500).send("Error fetching data");
  }
});


async function getData(tableName, res) {
  try {
    const connection = await mysql.createConnection(config);
    const [rows] = await connection.execute(`SELECT * FROM ${tableName}`);
    res.send(rows);
    await connection.end();
  } catch (err) {
    console.error(`Error fetching data from ${tableName}:`, err);
    res.status(500).send("Error fetching data");
  }
}
async function postData(tableName, req, res) {
  const data = req.body; // Дані, які прийшли в тілі запиту
  const columns = Object.keys(data).join(", ");
  const values = Object.values(data);
  const placeholders = values.map(() => "?").join(", ");
  
  const query = `INSERT INTO ${tableName} (${columns}) VALUES (${placeholders})`;

  try {
      const result = await queryDatabase(query, values);
      res.send({ success: true, result });
  } catch (error) {
      console.error(`Error inserting data into ${tableName}:`, error);
      res.status(500).send("Error inserting data");
  }
}


const tables = [
  "Users",
  "SurveyStatus",
  "Surveys",
  "Questions",
  "Answers",
  "Responses",
  "UserAnswers",
  "SurveyCategories",
  "SurveyCategoryAssignments",
];

app.get("/:table", (req, res) => {
  const tableName = req.params.table;
  if (tables.includes(tableName)) {
    getData(tableName, res);
  } else {
    res.status(404).send("Table not found");
  }
});

app.post("/:table", (req, res) => {
  const tableName = req.params.table;
  if (tables.includes(tableName)) {
    postData(tableName, req, res);
  } else {
    res.status(404).send("Table not found");
  }
});

app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});
