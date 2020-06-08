import { Router } from 'express';
import { getRelatedKeywords } from '../../services/relatedKeywords';
import { getConferences, filterConferences } from '../../services/eventService';
import { getLocation } from '../../services/geoLocation';

const eventsRoute = Router();

eventsRoute.get('/search', async (req, res) => {
  const inputKey = req.query.key || '';
  // Get 4 related keywords;
  const relatedKeywords = await getRelatedKeywords(inputKey, 4);
  const conferences = await getConferences(relatedKeywords);

  res.status(200).send(conferences);
});

eventsRoute.get('/filter', async (req, res) => {
  const { radius,place,limit } = req.query;


  const location = await getLocation(place);

  let conferences;
  if (limit === undefined) {
    // default limit size 30
    conferences = await filterConferences(radius, location, 30);
  } else {
    conferences = await filterConferences(radius, location, limit);
  }
 
 
  // Get 30 events with default limit or events as much as given limit.
  res.status(200).send(conferences);

});


export default eventsRoute;
