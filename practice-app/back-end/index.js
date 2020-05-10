const Joi = require('joi');
const mongoose = require('mongoose');
const users = require('./routes/users');
const auth = require('./routes/auth');
const test = require('./routes/test')
const express = require('express');
const app = express();
 
mongoose.connect('mongodb+srv://Baris:hulohulohulo@cluster0-envaa.mongodb.net/test?retryWrites=true&w=majority')
    .then(() => console.log('Now connected to MongoDB!'))
    .catch(err => console.error('Something went wrong', err));
 
app.use(express.json());
app.use('/api/register', users);
app.use('/api/login', auth);
app.use('/api/test', test);

 
const port = process.env.PORT || 4000;
app.listen(port, () => console.log(`Listening on port ${port}...`));