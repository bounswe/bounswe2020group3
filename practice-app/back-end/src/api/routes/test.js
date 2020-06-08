import { Router } from 'express';

const testRoute = Router();

testRoute.get('/', async (req, res) => {
  res.status(200).send({
    message: 'Test OK!',
  });
});

export default testRoute;
