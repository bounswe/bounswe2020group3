import fetch from "isomorphic-unfetch";
import config from "../config";

const getRequestURL = (path) => {
  return path.startsWith("/")
    ? `${config.API_URL}${path}`
    : `${config.API_URL}/${path}`;
};

export const sendRequest = (url, type, body) => {
    const requestURL = getRequestURL(url);
    if (type === "get") {
        return fetch(requestURL, {
            method: type,
            headers: {
                Accept: "application/json",
            },
        });
    }
    const parsed = JSON.parse(body);
    const stringified = JSON.stringify(parsed);
  return fetch(requestURL, {
    method: type,
    body: stringified,
    headers: {
      'Content-Type': "application/json",
      'Accept': "application/json, application/xml, text/plain, text/html, *.*",
    },
  });
};
