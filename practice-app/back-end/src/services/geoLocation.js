import config from '../config';
const fetch = require('isomorphic-unfetch');

const API_KEY = config.geo_location;


export const getLocation = async (place) => {
  
  if (place === undefined) {
    return null;
  }

  const url = `https://api.opencagedata.com/geocode/v1/json?q=${place}&key=${API_KEY}`;
  const ll = await fetch(url, {
    method: 'GET',
    headers: {
      'content-type': 'application/json',
    },
  }).then((response) => {
    if (response.status >= 400) {
      throw new Error("Bad response from server");
    }
    return response.json().then((res) => {
      // If location is not found, return null
      
      if (res.results.length == 0) {
        return null;
      } else {
        // Returns first location's latitude and longitude
        return res.results[0].geometry;
      }
    });
  });

  return ll;
}