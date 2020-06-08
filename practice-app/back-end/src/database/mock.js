import { MongoMemoryServer } from 'mongodb-memory-server';

const mongod = new MongoMemoryServer();

export const getMockDatabaseURI = async () => mongod.getUri();

export const closeMockDatabase = async () => mongod.stop();
