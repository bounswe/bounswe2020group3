import app from '../src/index';

const request = require('supertest');
const { expect } = require('chai');

describe('POST /correct news', () => {
  it('should fetch news succesfully', async () => {
    const response = await request(app)
      .post('/api/listNews')
      .send({
        email: '12345',
        password: '12345',
        registration_date:'12345',
        interestedAreas:['graph theory', 'shortest path']
      })
      .expect(201);
    expect(response.body.sourceId).to.exist;
  });
});
describe('POST /correct news', () => {
    it('should fetch news succesfully', async () => {
      const response = await request(app)
        .post('/api/listNews')
        .send({
          email: '123456456554',
          password: '12345asdasd',
          registration_date:'12345asdaf',
          interestedAreas:['graph theory', 'shortest path']
        })
        .expect(201);
      expect(response.body.url).to.exist;
    });
  });