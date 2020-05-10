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
 
    // Check if this user already exisits
    let user = await User.findOne({ email: req.body.email });
    if (user) {
        return res.status(400).send('That user already exisits!');
    } else {
        // Insert the new user if they do not exist yet
        user = new User({
            name: req.body.name,
            email: req.body.email,
            password: req.body.password,
            registration_date: Date().toString()
        });

        user.password = crypto(user.password, { asString: true });

        await user.save();
        res.send("Success!");
    }
});
 
module.exports = router;