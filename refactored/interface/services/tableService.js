const { executeQuery } = require("../config/db");
const { validateInsertData } = require("../validators/tableValidator");

const allowedTables = [
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

function isAllowedTable(tableName) {
  return allowedTables.includes(tableName);
}

async function getAllFromTable(tableName) {
  if (!isAllowedTable(tableName)) {
    throw new Error("INVALID_TABLE");
  }

  return executeQuery(`SELECT * FROM ${tableName}`);
}

async function insertIntoTable(tableName, data) {
  if (!isAllowedTable(tableName)) {
    throw new Error("INVALID_TABLE");
  }

  validateInsertData(data);

  const columns = Object.keys(data);
  const values = Object.values(data);

  const columnList = columns.join(", ");
  const placeholders = values.map(() => "?").join(", ");
  const query = `INSERT INTO ${tableName} (${columnList}) VALUES (${placeholders})`;

  return executeQuery(query, values);
}

module.exports = {
  allowedTables,
  isAllowedTable,
  getAllFromTable,
  insertIntoTable,
};