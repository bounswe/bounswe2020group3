const { User, validate } = require('../models/user');
const express = require('express');
const router = express.Router();
const crypto = require("sha256");

router.post('/', async (req, res) => {
    // First Validate The Request
    const { error } = validate(req.body);
    if (error) {
        return res.status(400).send(error.details[0].message);
    }

    let user = await User.findOne({ email: req.body.email });
    if (user) {
        const pw = user.password;
        const pw_hashed = crypto(req.body.password, { asString: true });
        if (pw_hashed === pw){
            return res.status(200).send('That user already exists! And its you mate!');
        }else { 
            return res.status(401).send(`Invalid username or password sifre yanlis`);
        }

        } else {
            return res.status(401).send('Invalid username or password! doesnt exist');

    }
});

module.exports = router;