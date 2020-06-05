import crypto from 'sha256';
const Joi = require('joi');
const mongoose = require('mongoose');

export const User = mongoose.model('User', new mongoose.Schema({
  name: {
    type: String,
    required: true,
    minlength: 5,
    maxlength: 50,
  },
  email: {
    type: String,
    required: true,
    minlength: 5,
    maxlength: 255,
    unique: true,
  },
  password: {
    type: String,
    required: true,
    minlength: 5,
    maxlength: 1024,
  },
  registration_date: {
    type: String,
    required: false,
  },
  
  topics: { 
	type: Array,
	required: false,
  }
}));

export function validateRegister(user) {
  const schema = {
    name: Joi.string().min(5).max(50).required(),
    email: Joi.string().min(5).max(255).required()
      .email(),
    password: Joi.string().min(5).max(255).required(),
    registration_date: Joi.string(),
    topics: Joi.array()

  };
  return Joi.validate(user, schema);
}

export function validateLogin(req) {
  const schema = {
    email: Joi.string().min(5).max(255).required()
      .email(),
    password: Joi.string().min(5).max(255).required(),
  };
  return Joi.validate(req, schema);
}

export function checkPassword(req, user) {
  return user.password === crypto(req.body.password, { asString: true });
}
