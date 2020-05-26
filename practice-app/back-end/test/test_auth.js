import app from '../src/index';

const request = require('supertest');
const { expect } = require('chai');

describe('POST /login with right credentials', () => {
  it('should login with success', async () => {
    const response = await request(app)
      .post('/api/login')
      .send({
        email: 'celalbaba33@hotmail.com',
        password: '123456',
      })
      .expect(200);
    expect(response.body.message).to.equal('Login Success!');
  });
});

describe('POST /login with wrong credentials', () => {
  it('should not login', async () => {
    const response = await request(app)
      .post('/api/login')
      .send({
        email: 'celalbaba33@hotmail.com',
        password: '1234567',
      })
      .expect(401);
    expect(response.body.message).to.contain('Invalid');
  });
});
