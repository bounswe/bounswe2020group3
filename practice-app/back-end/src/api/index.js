import { Router } from 'express';
import testRoute from './routes/test';
import registerRoute from './routes/users';
import loginRoute from './routes/auth';
import eventsRoute from './routes/events';

const indexRoute = Router();

indexRoute.use('/test', testRoute);
indexRoute.use('/register', registerRoute);
indexRoute.use('/login', loginRoute);
indexRoute.use('/events', eventsRoute);

export default indexRoute;
