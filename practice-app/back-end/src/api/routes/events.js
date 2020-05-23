import { Router } from 'express';
import { getRelatedKeywords } from '../../services/relatedKeywords';
import { getConferences } from '../../services/eventService';

const eventsRoute = Router();

eventsRoute.get('/search', async (req, res) => {
  const inputKey = req.query.key;
  // Get 4 related keywords;
  const relatedKeywords = await getRelatedKeywords(inputKey, 4);
  const conferences = await getConferences(relatedKeywords);

  res.status(200).send(conferences);
});

export default eventsRoute;
