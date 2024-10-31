import request from 'supertest';
import app from '../server';
import { connectDatabase, closeDatabase, clearDatabase } from './setup';

let token;

beforeAll(async () => {
    await connectDatabase();
    // Register and log in a user to get a token
    await request(app)
        .post('/api/users/register')
        .send({ username: 'user1', password: 'password123' });
    const res = await request(app)
        .post('/api/users/login')
        .send({ username: 'user1', password: 'password123' });
    token = res.body.token;
});
afterEach(async () => await clearDatabase());
afterAll(async () => await closeDatabase());

describe('Loan Operations', () => {
    it('should create a new loan', async () => {
        const res = await request(app)
            .post('/api/loans/create')
            .set('Authorization', `Bearer ${token}`)
            .send({ amount: 10000, term: 3 });
        
        expect(res.statusCode).toEqual(201);
        expect(res.body).toHaveProperty('_id');
        expect(res.body).toHaveProperty('amount', 10000);
        expect(res.body).toHaveProperty('term', 3);
    });

    it('should retrieve the user’s loans', async () => {
        await request(app)
            .post('/api/loans/create')
            .set('Authorization', `Bearer ${token}`)
            .send({ amount: 10000, term: 3 });

        const res = await request(app)
            .get('/api/loans/get')
            .set('Authorization', `Bearer ${token}`);

        expect(res.statusCode).toEqual(200);
        expect(res.body).toHaveLength(1);
    });

    it('should add a repayment for a loan', async () => {
        const loan = await request(app)
            .post('/api/loans/create')
            .set('Authorization', `Bearer ${token}`)
            .send({ amount: 10000, term: 3 });

        const res = await request(app)
            .post(`/api/loans/${loan.body._id}/repayments`)
            .set('Authorization', `Bearer ${token}`)
            .send({ amount: 5000 });

        expect(res.statusCode).toEqual(200);
        expect(res.body.repayments[0]).toHaveProperty('status', 'PAID');
        expect(res.body.repayments[0]).toHaveProperty('amount', 5000);
        expect(res.body.repayments[1]).toHaveProperty('status', 'PENDING');
        expect(res.body.repayments[1]).toHaveProperty('amount', 2500);
    });
});
