import { Router } from 'express';
import testRoute from './routes/test';
import usersRoute from './routes/users';
import authRoute from './routes/auth';

const indexRoute = Router();

indexRoute.use('/test', testRoute);
indexRoute.use('/users', usersRoute);
indexRoute.use('/login', authRoute);

export default indexRoute;
