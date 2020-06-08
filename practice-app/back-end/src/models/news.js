const mongoose = require('mongoose')

const newsSchema = new mongoose.Schema({
  sourceId: {
    type: String,
    required: false
  },
  sourceName: {
    type: String,
    required: false
  },
  author: {
    type: String,
    required: false
  },
  title: {
    type: String,
    required: false
  },
  description: {
    type: String,
    required: false
  },
  url: {
    type: String,
    required: false
  },
   urlImage: {
    type: String,
    required: false
  },
  publishedAt: {
    type: String,
    required: false
  },
  content: {
    type: String,
    required: false
  },
  
  relatedUser: {
    type: String,
    required: false
  },

})

module.exports = mongoose.model('News', newsSchema)
