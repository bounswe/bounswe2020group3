import fetch from 'isomorphic-unfetch';
import config from '../config';

export const getConferences = async (keywords) => {
  const API_KEY = config.predict_api_key;
  const fetchPromises = keywords.map(async (keyword) => {
    const params = `?label.op=any&label=conference,science,health&q=${keyword}`;
    const response = await fetch(`https://api.predicthq.com/v1/events/${params}`, {
      method: 'get',
      headers: {
        Authorization: `Bearer ${API_KEY}`,
        Accept: 'application/json',
      },
    });
    const json = await response.json();
    const list = [];
    json.results.forEach((result) => {
      list.push({
        title: result.title,
        description: result.description,
        labels:result.labels,
        start: result.start,
        end: result.end,
        timezone: result.timezone,
        location: result.location,
        scope: result.scope,
        country: result.country,
      });
    });
    return list;
  });
  let conferences = [];
  const conferenceArrays = await Promise.all(fetchPromises);
  conferenceArrays.forEach((array) => {
    conferences = conferences.concat(array);
  });
  return {
    count: conferences.length,
    results: conferences,
  };
};
