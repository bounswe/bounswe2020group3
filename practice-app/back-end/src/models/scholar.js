// import { Article } from './Article';


const mongoose = require('mongoose');

// eslint-disable-next-line no-undef
const Article = new mongoose.Schema({
  name: {
    type: String,
    required: true,
  },
  contributors: {
    type: String,
    default: '',
  },
  url: {
    type: String,
    default: '',
  },

});

export const Scholar = mongoose.model('Scholar', new mongoose.Schema({
  name: {
    type: String,
    minlength: 5,
    maxlength: 50,
    required: true,
  },
  bio: {
    type: String,
    default: '',
  },
  area: {
    type: String,
    default: '',
  },
  scholar_id: {
    type: String,
    required: false,
    default: '',
  },
  articles: {
    type: [Article],
  },
}));
