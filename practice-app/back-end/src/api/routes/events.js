import { Router } from 'express';
import { getRelatedKeywords } from '../../services/relatedKeywords';
import { getConferences, filterConferences } from '../../services/eventService';
import { getLocation } from '../../services/geoLocation';

const eventsRoute = Router();

eventsRoute.get('/search', async (req, res) => {
  const inputKey = req.query.key;
  // Get 4 related keywords;
  const relatedKeywords = await getRelatedKeywords(inputKey, 4);
  const conferences = await getConferences(relatedKeywords);

  res.status(200).send(conferences);
});

eventsRoute.get('/filter', async (req, res) => {
  const { radius, place } = req.query;

  const location = await getLocation(place);
  // Get 30 events within given place around radius.
  const conferences = await filterConferences(radius, location, 30);

  res.status(200).send(conferences);
});


export default eventsRoute;
