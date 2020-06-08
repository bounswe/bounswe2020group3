import fetch from 'isomorphic-unfetch';
import config from '../config';

const API_KEY = config.predict_api_key;

export const filterConferences = async (radius,location,limit) => {
  const list = [];
  let params = '';
  let ll = '';
  if (location != null){
    ll = `${location.lat},${location.lng}`;
    params = `?label.op=any&label=conference,science,career,education,technology&within=${radius}km@${ll}&limit=${limit}`;
    const response = await fetch(`https://api.predicthq.com/v1/events/${params}`, { 
      method:'get',
      headers: {
        Authorization: `Bearer ${API_KEY}`,
        Accept: 'application/json',
      },
    });
    const json = await response.json();
    json.results.forEach((result) => {
      list.push({
        title: result.title,
        description: result.description,
        labels: result.labels,
        start: result.start,
        end: result.end,
        country: result.country,
        state: result.state,
        address: result.entities[0],
      });
    });
  }
  
  return {
    count: list.length,
    conferences: list,
  };
};

export const getConferences = async (keywords) => {
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
        labels: result.labels,
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
