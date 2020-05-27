const mongoose = require('mongoose')

const newsSchema = new mongoose.Schema({
  sourceId: {
    type: String,
    required: false
  },
  sourceName: {
    type: String,
    required: true
  },
  author: {
    type: String,
    required: true
  },
  title: {
    type: String,
    required: true
  },
  description: {
    type: String,
    required: true
  },
  url: {
    type: String,
    required: true
  },
   urlImage: {
    type: String,
    required: true
  },
  publishedAt: {
    type: String,
    required: true
  },
  content: {
    type: String,
    required: true
  },
  
  relatedUser: {
    type: String,
    required: false
  },

})

module.exports = mongoose.model('News', newsSchema)
