const mysql = require("mysql2/promise");

const dbConfig = {
  host: process.env.DB_HOST || "127.0.0.1",
  user: process.env.DB_USER || "root",
  password: process.env.DB_PASSWORD || "password",
  database: process.env.DB_NAME || "OnlineSurveys",
};

async function executeQuery(query, params = []) {
  let connection;

  try {
    connection = await mysql.createConnection(dbConfig);
    const [results] = await connection.execute(query, params);
    return results;
  } finally {
    if (connection) {
      await connection.end();
    }
  }
}

module.exports = {
  executeQuery,
};