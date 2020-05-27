import { Router } from 'express';
import testRoute from './routes/test';
import registerRoute from './routes/users';
import loginRoute from './routes/auth';
import scholarRoute from './routes/scholars';
import eventsRoute from './routes/events';
import newsRouter from './routes/listNews';
import usersRouter from './routes/users';

const indexRoute = Router();

indexRoute.use('/test', testRoute);
indexRoute.use('/register', registerRoute);
indexRoute.use('/login', loginRoute);
indexRoute.use('/scholars', scholarRoute);
indexRoute.use('/events', eventsRoute);
indexRoute.use('/listNews', newsRouter);
indexRoute.use('/users', usersRouter);

export default indexRoute;
