const express = require("express");
const bodyParser = require("body-parser");
const cors = require("cors");
require("dotenv").config();

const surveyRoutes = require("./routes/surveyRoutes");

const app = express();
const port = process.env.PORT || 3000;

app.use(bodyParser.json());
app.use(cors());

app.use("/", surveyRoutes);

app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});