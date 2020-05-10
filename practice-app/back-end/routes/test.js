const express = require('express');
const testRoute = express.Router();

testRoute.get('/', async (req, res) => {
  res.status(200).send("Test OK!");
});

module.exports = testRoute;
