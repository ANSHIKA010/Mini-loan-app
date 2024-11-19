import express from 'express';
import dotenv from 'dotenv';
import userRoutes from './routes/userRoutes.js';
import loanRoutes from './routes/loanRoutes.js';
import cors from 'cors';

dotenv.config();

const app = express();
app.use(cors());

app.use(express.json());
app.use('/api/users', userRoutes);     // User-related routes
app.use('/api/loans', loanRoutes);    // Loan-related routes

export default app;


