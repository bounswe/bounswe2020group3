import { Router } from 'express';
import crypto from 'sha256';
import { User, validateRegister } from '../../models/user';

const router = Router();

router.post('/', async (req, res) => {
  // First Validate The Request
  const body1 = req.body;
  console.log(body1);
  const { error } = validateRegister(req.body);
  if (error) {
    return res.status(400).send({
      message: error.details[0].message,
    });
  }

  // Check if this user already exisits
  let user = await User.findOne({ email: req.body.email });
  if (user) {
    return res.status(400).send({
      message: 'That user already exisits!',
    });
  }
  // Insert the new user if they do not exist yet
  user = new User({
    name: req.body.name,
    email: req.body.email,
    password: req.body.password,
    registration_date: Date().toString(),
    topics: req.body.topics,
  });

  user.password = crypto(user.password, { asString: true });

  await user.save();
  res.send({
    message: 'Success!',
  });
});

router.get('/', async (req, res) => {
  if (res.statusCode === 400) {
    return res.status(400);
  }
  const users = await User.find({}).select('email registration_date topics');
  return res.send(users);
});

export default router;
