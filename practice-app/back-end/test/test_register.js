import app from '../src/index';
const { expect } = require('chai');
const request = require('supertest');


// For generating random emails at random legnths
function makeid(length) {
    var result           = '';
    var characters       = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    var charactersLength = characters.length;
    for ( var i = 0; i < length; i++ ) {
       result += characters.charAt(Math.floor(Math.random() * charactersLength));
    }
    return result + '@yohey.com.uk';
 }

var email = makeid(Math.random() * 13); 
var pw = '1234567890';
var topics = ["atv", 'kanald', 'duzdunya', 'flatearth', 'filatört']

const users = {
  name: "osmanaga",
  email: email,
  password: pw,
  topics: topics
};
describe('POST /register with right credentials', () => {
  it('should register with success', async () => {
    const response = await request(app)
      .post('/api/register')
      .send(users)
      .expect(200);
    expect(response.text).to.equal('Success!');
  });
});

describe('POST /register with wrong credentials', () => {
  it('should not register -- duplicate', async () => {
    const response = await request(app)
      .post('/api/register')
      .send(users)
      .expect(400);
    expect(response.text).to.contain('That user already exisits!');
  });
});
