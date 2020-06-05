import app from '../src/index';
const { expect } = require('chai');
const request = require('supertest');

var newScholar;

describe('POST /create scholar with right info', () => {
    it('should create with success', async () => {
        
        const scholarBody = {
            name: "Celal Şengör",
            bio: "A respected academic in İstanbul Technical University",
            area: "Geology",
            scholar_id: "GE3svVEAAAAJ",
            articles: []
        };

        const response = await request(app)
            .post('/api/scholars')
            .send(scholarBody)
            .expect(201);

        newScholar = response.body;
        expect(newScholar._id).to.exist;
    });
});



describe('GET /get all scholars', () => {
    it('should get all scholars', async () => {
        const response = await request(app)
            .get('/api/scholars')
            .expect(200);
    });
});

describe('GET /get one scholar', () => {
    it('should get one scholar', async () => {
        const response = await request(app)
            .get('/api/scholars/:id').send({ _id: newScholar._id })
            .expect(200);

        var scholar = response.body;
        expect(scholar._id).to.equal(newScholar._id);
    });
});


describe('PATCH /update a scholar', () => {
    it('should update a scholar', async () => {

        const updateScholar = {
            _id: newScholar._id,
            bio: "UPDATED BIO",
            area: "UPDATED AREA",
        };

        const response = await request(app)
            .patch('/api/scholars/:id').send(updateScholar)
            .expect(200);
    });
});

describe('DELETE /delete a scholar', () => {
    it('should delete a scholar', async () => {
        const response = await request(app)
            .delete('/api/scholars/').send({ _id: newScholar._id })
            .expect(200);
    });
});