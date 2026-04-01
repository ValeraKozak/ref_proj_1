const { executeQuery } = require("../config/db");

async function getUsersWhoWantImprovements() {
  const query = `
    SELECT DISTINCT Users.username, UserAnswers.text_answer
    FROM Users
    JOIN Responses ON Users.user_id = Responses.user_id
    JOIN UserAnswers ON Responses.response_id = UserAnswers.response_id
    WHERE UserAnswers.text_answer LIKE '%покращити%';
  `;

  return executeQuery(query);
}

async function getTopSurveyCompleter() {
  const query = `
    SELECT Users.username, COUNT(Responses.response_id) AS total_surveys
    FROM Users
    JOIN Responses ON Users.user_id = Responses.user_id
    GROUP BY Users.username
    ORDER BY total_surveys DESC
    LIMIT 1;
  `;

  return executeQuery(query);
}

async function getSurveyStatistics() {
  const query = `CALL GetSurveyStatistics();`;
  return executeQuery(query);
}

module.exports = {
  getUsersWhoWantImprovements,
  getTopSurveyCompleter,
  getSurveyStatistics,
};