const express = require('express')
const router = express.Router()

const News = require('../models/news');
const User = require('../models/user');
const Request = require("request"); //using for http requests
const util = require('util'); //making request work with await function
const requestPromise = util.promisify(Request);

// Create new news about given paramaters
router.get('/:userId', async (req, res) => {
   const user = await User.findById(req.params.userId);
   const interestedAreas =user.interestedAreas;
  var i;
  var newsList= [];
  
  for(i = 0; i < interestedAreas.length; i++)
  {
	searchWord = interestedAreas[i];
	//constructing http link for using newsAPI
	const http= "http://newsapi.org/v2/everything?q="+searchWord+"&sortBy=publishedAt&apiKey=518571c399c94e0f9704b87d9b60941d";
	var news='empty';
	const response = await requestPromise(http);
	if(response.error){
	  console.dir('http request failure');
	  res.status(400).json({ message: response.error })
	  return;
	}
	data=JSON.parse(response.body);
	if(data['status']=='error'){
		console.dir('Error type = '+data['code']);
		console.dir('Error message = '+data['message'])
		res.status(400).json({ code: data['code'] ,message: data['message'] })
		return;
	}
	else if (data['status']=='ok') { //getting just 1 news for each interested area for given user
		news= new News( 
		{
		sourceID: data['articles'][0]['source']['id'],
		sourceName: data['articles'][0]['source']['name'],
		author: data['articles'][0]['author'],
		title: data['articles'][0]['title'],
		description: data['articles'][0]['description'],
		url: data['articles'][0]['url'],
		urlImage: data['articles'][0]['urlToImage'],
		publishedAt: data['articles'][0]['publishedAt'],
		content: data['articles'][0]['content'],
		relatedUser: req.params.userId, 
		}
		);
	}
	 const newNews = await news.save() //save News to database
	 newsList.push(newNews);
}
  try {
    
    res.status(201).json(newsList)
  } catch (err) {
    res.status(400).json({ message: err.message })
  }
})

module.exports = router
