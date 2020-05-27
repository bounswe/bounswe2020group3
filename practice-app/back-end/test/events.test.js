import app from '../src/index';
import { getConferences } from '../src/services/eventService';
import { getRelatedKeywords } from '../src/services/relatedKeywords';

const request = require('supertest');
const { expect } = require('chai');
const { getLocation } = require('../src/services/geoLocation');

// app.listen();

// Test in terminal only this test
// ./node_modules/mocha/bin/mocha  -r esm --timeout 10000 src/api/routes/events.test.js

describe('GET /events/filter with no parameters', () => {
  it('should respond with all events without no filtering', async () => {
    const response = await request(app)
      .get('/api/events/filter')
      .expect(200);
    expect(response.body.count).to.greaterThan(0);
  });
});

describe('GET /events/filter with some paramaters', () => {
  it('should respond with some event', async () => {
    const response = await request(app)
      .get('/api/events/filter?radius=1&place=Seattle')
      .expect(200);
    expect(response.body.count).greaterThan(0);
  });
});

describe('GET /events/filter with some paramaters', () => {
  it('should respond with no result', async () => {
    const response = await request(app)
      .get('/api/events/filter?radius=1&place=Zonguldak')
      .expect(200);
    expect(response.body.conferences).to.have.lengthOf(0);
  });
});

describe('/GET geoLocation service with place parameter', () => {
  it('should respond with null', async () => {
    const response = await getLocation('aplacethatisnotintheworld');
    expect(response).to.equal(null);
  });
  it('should respond with lattitude and longitutude', async () => {
    const response = await getLocation('Istanbul');
    const result = response.split(' ').map(Number);
    expect(result).to.deep.equal([41.009998, 28.950001]);
  });
});

describe('eventService / getRelatedKeywords method', () => {
  it('should respond with a list of keywords for a valid keyword', async () => {
    const response = await getRelatedKeywords('test', 10);
    expect(response).to.be.an('array');
    expect(response).to.have.length.lessThan(12);
  });

  it('should respond with an empty list for empty string', async () => {
    const response = await getRelatedKeywords('', 10);
    expect(response).to.be.an('array');
    expect(response).to.have.length(1);
  });
});

describe('eventService / getConferences method', () => {
  it('should respond with a list of conferences for a valid keyword list', async () => {
    const response = await getConferences(['machine learning', 'ai']);
    expect(response).to.have.property('count').to.be.a('number');
    expect(response).to.have.property('results').to.be.an('array');
    const { results } = response;
    results.forEach((result) => {
      expect(result).to.have.property('title');
      expect(result).to.have.property('description');
      expect(result).to.have.property('labels');
      expect(result).to.have.property('start');
      expect(result).to.have.property('end');
      expect(result).to.have.property('timezone');
      expect(result).to.have.property('location');
      expect(result).to.have.property('scope');
      expect(result).to.have.property('country');
    });
  });

  it('should respond with an empty list of conferences for an empty list', async () => {
    const response = await getConferences([]);
    expect(response).to.have.property('count').to.be.a('number').to.equal(0);
    expect(response).to.have.property('results').to.be.an('array').to.have.length(0);
  });
});

describe('GET  events/search', () => {
  it('should respond with a list of conferences for a valid key', async () => {
    const response = await request(app)
      .get('/api/events/search?key=machine learning')
      .expect(200);
    expect(response.body.count).to.be.a('number').to.be.greaterThan(0);
    expect(response.body.results).to.be.an('array').to.have.length.greaterThan(0);
    response.body.results.forEach((result) => {
      expect(result).to.have.property('title');
      expect(result).to.have.property('description');
      expect(result).to.have.property('labels');
      expect(result).to.have.property('start');
      expect(result).to.have.property('end');
      expect(result).to.have.property('timezone');
      expect(result).to.have.property('location');
      expect(result).to.have.property('scope');
      expect(result).to.have.property('country');
    });
  });

  it('should respond with a list of conferences for an empty key', async () => {
    const response = await request(app)
      .get('/api/events/search')
      .expect(200);
    expect(response.body.count).to.be.a('number').to.be.greaterThan(0);
    expect(response.body.results).to.be.an('array').to.have.length.greaterThan(0);
    response.body.results.forEach((result) => {
      expect(result).to.have.property('title');
      expect(result).to.have.property('description');
      expect(result).to.have.property('labels');
      expect(result).to.have.property('start');
      expect(result).to.have.property('end');
      expect(result).to.have.property('timezone');
      expect(result).to.have.property('location');
      expect(result).to.have.property('scope');
      expect(result).to.have.property('country');
    });
  });
});
