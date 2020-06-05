require('dotenv').config();

export default {
  port: process.env.PORT,
  databaseURL: process.env.DATABASE_CONNECTION,
  databaseURL2: process.env.DATABASE_CONNECTION2,
  api: {
    prefix: '/api',
  },
  predict_api_key: process.env.PREDICT_API_KEY,
  geo_location: process.env.GEO_LOCATION,
};
