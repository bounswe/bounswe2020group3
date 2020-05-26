import express from 'express';
import bodyParser from 'body-parser';
import indexRoute from './api';
import config from './config';
import { connectDatabase } from './database';

// Create app instance
const app = express();
const cors = require('cors');

// Middleware
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

// Use Cors
app.use(cors());

// Load API routes
app.use(config.api.prefix, indexRoute);

app.get('/',(req, res) => {
  res.json({
    message: 'WELCOME THE PAPERLAYER 👋',
  });
})

connectDatabase();
// Start Server
const { port } = config;
app.listen(port, () => {
  console.log(`Server listening on port: ${port}`);
});

export default app;
