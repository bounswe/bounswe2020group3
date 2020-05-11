import mongoose from 'mongoose';
import config from './config';

export const connectDatabase = () => {
  mongoose
    .connect(config.databaseURL, {
      useNewUrlParser: true,
      useFindAndModify: false,
      useUnifiedTopology: true,
    })
    .then(() => {
      console.log('Database connected.');
    })
    .catch((err) => {
      console.log(`Database connection error ${err}`);
    });
};
