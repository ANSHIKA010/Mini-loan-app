import request from 'supertest';
import app from '../server';
import { connectDatabase, closeDatabase, clearDatabase } from './setup';

let adminToken, userToken, loanId;

beforeAll(async () => {
    await connectDatabase();

    // Register and log in as an admin
    await request(app)
        .post('/api/users/register')
        .send({ username: 'admin', password: 'password123', isAdmin: true });
    const adminRes = await request(app)
        .post('/api/users/login')
        .send({ username: 'admin', password: 'password123' });
    adminToken = adminRes.body.token;

    // Register and log in as a regular user, then create a loan
    await request(app)
        .post('/api/users/register')
        .send({ username: 'user1', password: 'password123' });
    const userRes = await request(app)
        .post('/api/users/login')
        .send({ username: 'user1', password: 'password123' });
    userToken = userRes.body.token;

    const loanRes = await request(app)
        .post('/api/loans/create')
        .set('Authorization', `Bearer ${userToken}`)
        .send({ amount: 5000, term: 2 });
    loanId = loanRes.body._id;
});
afterAll(async () => await closeDatabase());

describe('Admin Actions', () => {
    it('should allow an admin to approve a pending loan', async () => {
        const res = await request(app)
            .put(`/api/loans/${loanId}/approve`)
            .set('Authorization', `Bearer ${adminToken}`);
        
        expect(res.statusCode).toEqual(200);
        expect(res.body).toHaveProperty('status', 'APPROVED');
    });

    it('should retrieve all loans for the admin', async () => {
        const res = await request(app)
            .get('/api/loans/all')
            .set('Authorization', `Bearer ${adminToken}`);
        
        expect(res.statusCode).toEqual(200);
        expect(res.body).toHaveLength(1);
    });
});
