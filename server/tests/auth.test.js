import request from 'supertest';
import app from '../server';  // Import the Express app
import { connectDatabase, closeDatabase, clearDatabase } from './setup';

beforeAll(async () => await connectDatabase());
afterEach(async () => await clearDatabase());
afterAll(async () => await closeDatabase());

describe('Authentication', () => {
    it('should register a new user', async () => {
        const res = await request(app)
            .post('/api/users/register')
            .send({ username: 'testuser', password: 'password123' });
        expect(res.statusCode).toEqual(201);
        expect(res.body).toHaveProperty('message', 'User registered successfully');
    });

    it('should log in an existing user and return a token', async () => {
        await request(app)
            .post('/api/users/register')
            .send({ username: 'testuser', password: 'password123' });
        
        const res = await request(app)
            .post('/api/users/login')
            .send({ username: 'testuser', password: 'password123' });

        expect(res.statusCode).toEqual(200);
        expect(res.body).toHaveProperty('token');
        expect(res.body).toHaveProperty('user');
        expect(res.body.user).toHaveProperty('username', 'testuser');
    });
});
