import { Router } from 'express';
import { Scholar } from '../../models/scholar';
import { func } from 'joi';

const gScholar = require('google-scholar-extended');
const mongoose = require('mongoose');
const { ObjectId } = require('mongodb');

const scholarRoute = Router();

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

// Get all scholars
scholarRoute.get('/', async (req, res) => {
  try {
    const scholars = await Scholar.find();
    res.json(scholars);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }

});

// Creating one scholar
scholarRoute.post('/', async (req, res) => {
  // eslint-disable-next-line no-use-before-define
  let articlesnew = await getGoogleScholar(req.body.scholar_id);

  // eslint-disable-next-line no-const-assign,no-undef
  articlesnew = articlesnew.concat(req.body.articles);
  const scholar = new Scholar({
    name: req.body.name,
    bio: req.body.bio,
    area: req.body.area,
    scholar_id: req.body.scholar_id,
    articles: articlesnew,
  });

  try {
    const newscholar = await scholar.save();
    res.status(201).json(newscholar);
  } catch (err) {
    res.status(400).json({ message: err.message });
  }
});

// Getting one scholar
// eslint-disable-next-line no-use-before-define
scholarRoute.get('/single', getScholar, async (req, res) => {
  res.json(res.scholar);
});

// Deleting one scholar
// eslint-disable-next-line no-use-before-define
scholarRoute.delete('/', getScholaranddelete, async (req, res) => {
  try {
    res.json({ message: 'Deleted This scholar' });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});
// Updating one scholar
// eslint-disable-next-line no-use-before-define
scholarRoute.patch('/', getScholar, async (req, res) => {
  if (req.query.bio != null) {
    res.scholar.bio = req.query.bio;
  }
  if (req.query.area != null) {
    res.scholar.area = req.query.area;
  }
  if (req.query.scholar_id != null) {
    res.scholar.scholar_id = req.query.scholar_id;
    // eslint-disable-next-line no-use-before-define,no-unused-vars
    let articlesnew = await getGoogleScholar(req.query.scholar_id);

    // eslint-disable-next-line no-const-assign,no-undef
    articlesnew = articlesnew.concat(res.scholar.articles);
    res.scholar.articles = articlesnew;
  }

  try {
    const updatedScholar = await res.scholar.save();
    res.json(updatedScholar);
  } catch {
    // eslint-disable-next-line no-undef
    res.status(400).json({ message: err.message });
  }
});

// Middleware function for gettig scholar object by its name in the body
async function getScholar(req, res, next) {
  let scholar = null;
  try {
    scholar = await Scholar.find({ _id: ObjectId(req.query._id) });
    if (scholar == null || scholar.length == 0) {
      return res.status(404).json({ message: 'Cant find scholar' });
    }
  } catch (err) {
    return res.status(500).json({ message: err.message });
  }
  res.scholar = scholar[0];
  next();
}

async function getScholaranddelete(req, res, next) {
  try {
    await Scholar.findOneAndDelete({ _id: ObjectId(req.body._id) });
  } catch (err) {
    return res.status(500).json({ message: err.message });
  }
  next();
}

// Returns Scholar's articles from Google Scholar
// eslint-disable-next-line no-unused-vars
async function getGoogleScholar(scholarID) {
  // eslint-disable-next-line no-unused-vars
  let arr = await gScholar.profile(scholarID);

  arr = arr.results;

  // eslint-disable-next-line no-unused-vars
  const arr2 = [];
  let i;
  // eslint-disable-next-line no-plusplus
  for (i = 0; i < arr.length; i++) {
    // eslint-disable-next-line no-var,vars-on-top
    let j;
    let authors;
    // eslint-disable-next-line prefer-destructuring
    authors = arr[i].authors[0].name;
    // eslint-disable-next-line no-plusplus
    for (j = 1; j < arr[i].authors.length; j++) {
      authors += ` ,${arr[i].authors[j].name}`;
    }
    arr2[i] = ({
      name: arr[i].title, contributors: authors, url: arr[i].citedUrl, year: arr[i].year,
    });
  }
  return arr2;
}

export default scholarRoute;
