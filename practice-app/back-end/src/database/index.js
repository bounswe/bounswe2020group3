import mongoose from 'mongoose';
import config from '../config';
import { getMockDatabaseURI } from './mock';

export const connectDatabase = async () => {
  const connectionURI = config.isTesting()
    ? await getMockDatabaseURI()
    : config.databaseURL;

  mongoose
    .connect(connectionURI, {
      useNewUrlParser: true,
      useFindAndModify: false,
      useUnifiedTopology: true,
      useCreateIndex: true,
    })
    .then(() => {
      console.log('Database connected.');
    })
    .catch((err) => {
      console.log(`Database connection error ${err}`);
    });
};
