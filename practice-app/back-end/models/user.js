const Joi = require('joi');
const mongoose = require('mongoose');
 
const User = mongoose.model('User', new mongoose.Schema({
    name: {
        type: String,
        required: true,
        minlength: 5,
        maxlength: 50
    },
    email: {
        type: String,
        required: true,
        minlength: 5,
        maxlength: 255,
        unique: true
    },
    password: {
        type: String,
        required: true,
        minlength: 5,
        maxlength: 1024
    },
    registration_date : {
        type:String,
        required: false
    }
}));
 
function validateUser(user) {
    const schema = {
        name: Joi.string().min(5).max(50).required(),
        email: Joi.string().min(5).max(255).required().email(),
        password: Joi.string().min(5).max(255).required(),
        registration_date : Joi.string()

    };
    return Joi.validate(user, schema);
}
 
exports.User = User;
exports.validate = validateUser;