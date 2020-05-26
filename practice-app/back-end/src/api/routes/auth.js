import { Router } from 'express';
import { User, validateLogin, checkPassword } from '../../models/user';

const router = Router();
const jwt = require('jsonwebtoken');

router.post('/', async (req, res) => {
  // First Validate The Request
  const { error } = validateLogin(req.body);
  if (error) {
    return res.status(400).send(error.details[0].message);
  }

  const user = await User.findOne({ email: req.body.email });
  if (!user) {
    return res.status(401).send({ message: 'Invalid username or password! User yok' });
  }

  const checkPass = checkPassword(req, user);

  if (!checkPass) {
    return res.status(401).send({ message: 'Invalid username or password! Sifre bozuk' });
  }

  const token = jwt.sign({ id: user.id }, 'PrivateKey', { expiresIn: '15m' });
  res.send({ message: 'Login Success!', user_token: token });
});

export default router;
