const config = require('../config');
const fetch = require('isomorphic-unfetch');


export const getLocation = async (location) => {
  const url = `https://devru-latitude-longitude-find-v1.p.rapidapi.com/latlon.php?location=${location}`;
  var options = {
    method: 'GET',
    headers: {
      'x-rapidapi-host': 'devru-latitude-longitude-find-v1.p.rapidapi.com',
      'x-rapidapi-key': config.default.geo_location,
      Accept: 'application/json'
    }
  };
  const ll = await fetch(url,options).then((response)=>{
    if (response.status >= 400) {
      throw new Error("Bad response from server");
    }
    return response.json().then((res) => {
      // If location is not found, return null
      if (res.Results.length == 0) {
        return null;
      } else {
        // Returns first location's latitude and longitude
        return res.Results[0].ll;
      }
    });
  });

  return ll;
}