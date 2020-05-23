import fetch from 'isomorphic-unfetch';

/**
 *
 * @param {*} input word that to be searched
 * @param {*} N number of related keywords
 */
export const getRelatedKeywords = async (input, N) => {
  const keywords = input.replace(' ', '+');
  // Fetch related keywords
  const response = await fetch(`https://api.datamuse.com/words?ml=${keywords}`);
  let responseList = await response.json();
  // Take first 10 related keywords
  responseList = responseList.splice(0, N);
  // Extract words from objects
  const relatedKeywords = [input];
  responseList.forEach((key) => {
    relatedKeywords.push(key.word);
  });

  return relatedKeywords;
};
