import { Router } from 'express';
import crypto from 'sha256';

import { User, validateLogin } from '../../models/user';

const router = Router();

router.post('/', async (req, res) => {
  // First Validate The Request
  const { error } = validateLogin(req.body);
  if (error) {
    return res.status(400).send(error.details[0].message);
  }

  const user = await User.findOne({ email: req.body.email });
  if (user) {
    const pw = user.password;
    const pw_hashed = crypto(req.body.password, { asString: true });
    if (pw_hashed === pw) {
      return res.status(200).send('That user already exists! And its you mate!');
    }
    return res.status(401).send('Invalid username or password sifre yanlis');
  }
  return res.status(401).send('Invalid username or password! doesnt exist');
});

export default router;
