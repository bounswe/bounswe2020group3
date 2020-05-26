const expect = require('expect');
const request = require('supertest');

const { app } = require('../src/index');

const { User } = require('../src/models/user');
const { users, addDummyUsers } = require('./seed/seed');


beforeEach(addDummyUsers);

describe('POST /users/login', () => {
  it('Should login user and return auth token', (done) => {
    request(app)
      .post('/users/login')
      .send({
        email: users[1].email,
        password: users[1].password,
      })
      .expect(200)
      .expect((res) => {
        expect(res.headers['x-auth']).not.toBeNull();
      })
      .end((err, res) => {
        if (err) return done(err);
        User.findById(users[1].id).then((user) => {
          expect(user.tokens[1]).toHaveProperty('access', 'auth');
          expect(user.tokens[1]).toHaveProperty('token', res.headers['x-auth']);
          done();
        }).catch((err) => done(err));
      });
  });
  it('Should reject invalid login', (done) => {
    request(app)
      .post('/users/login')
      .send({
        email: users[1].email,
        password: users[1].password + '1'
      })
      .expect(400)
      .expect((res) => {
        expect(res.headers['x-auth']).toBeUndefined();
      })
      .end((err, res) => {
        if (err) return done(err);
        User.findById(users[1].id).then((user) => {
          expect(user.tokens.length).toBe(1);
          done();
        }).catch((err) => done(err));
      });
  });
});
