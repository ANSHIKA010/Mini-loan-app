import express from 'express';
import connectDB from './config/db.js';
import dotenv from 'dotenv';
import userRoutes from './routes/userRoutes.js';
import loanRoutes from './routes/loanRoutes.js';

dotenv.config();

const app = express();
connectDB();

app.use(express.json());
app.use('/api/users', userRoutes);     // User-related routes
app.use('/api/loans', loanRoutes);    // Loan-related routes

const PORT = process.env.PORT || 5000;
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));

