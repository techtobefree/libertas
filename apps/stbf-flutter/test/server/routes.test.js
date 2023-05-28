const chai = require('chai');
const chaiHttp = require('chai-http');
const server = require('./server'); // Assuming your server file is named server.js

// Configure chai
chai.use(chaiHttp);
const expect = chai.expect;


describe('Server Routes', () => {
    describe('GET /projects', () => {
      it('should return all projects', (done) => {
        chai
          .request(server)
          .get('/projects')
          .end((err, res) => {
            expect(res).to.have.status(200);
            expect(res.body).to.be.an('array');
            // Add more assertions as needed to validate the response
            done();
          });
      });
    });
  
    // Add more test cases for other routes
  });
  