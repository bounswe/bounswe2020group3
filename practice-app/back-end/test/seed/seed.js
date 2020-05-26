const { ObjectID } = require('mongodb');
const jwt = require('jsonwebtoken');

const { User } = require('../../src/models/user');

const userOneID = new ObjectID();
const userTwoID = new ObjectID();
const users = [{
  _id: userOneID,
  email: 'person1@gmail.com',
  password: 'person1PASSWORD',
  tokens: [{
    access: 'auth',
    token: jwt.sign({ _id: userOneID, access: 'auth' }, process.env.JWT_SECRET).toString(),
  }],
}, {
  _id: userTwoID,
  email: 'person2@gmail.com',
  password: 'person2PASSWORD',
  tokens: [{
    access: 'auth',
    token: jwt.sign({ _id: userTwoID, access: 'auth' }, process.env.JWT_SECRET).toString(),
  }],
}];


const addDummyUsers = (done) => {
  User.deleteMany({}).then(() => {
    const userOne = new User(users[0]).save();
    const userTwo = new User(users[1]).save();

    return Promise.all([userOne, userTwo]);
  }).then(() => done());
};

module.exports = {
  users,
  addDummyUsers,
};
