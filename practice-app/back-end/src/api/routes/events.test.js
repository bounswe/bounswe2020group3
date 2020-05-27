import app from '../../index';

const request = require('supertest');
const { expect } = require('chai');
const { getLocation } = require('../../services/geoLocation');

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
