const express = require("express");
const controller = require("../controllers/surveyController");

const router = express.Router();

router.get("/user-answers/improve", controller.getUsersWhoWantImprovements);
router.get("/users/top-survey-completer", controller.getTopSurveyCompleter);
router.get("/survey-statistics", controller.getSurveyStatistics);

router.get("/:table", controller.getTableData);
router.post("/:table", controller.postTableData);

module.exports = router;