import express from 'express';
import { createLoan, approveLoan, getUserLoans, addRepayment, getAllLoans } from '../controllers/loanController.js';
import authMiddleware from '../middlewares/authMiddleware.js';
import roleMiddleware from '../middlewares/roleMiddleware.js';

const {Router} = express;
const router = Router();

router.post('/create', authMiddleware, createLoan);
router.put('/:loanId/approve', authMiddleware, roleMiddleware('admin'), approveLoan);
router.get('/get', authMiddleware, getUserLoans);
router.get('/all', authMiddleware, roleMiddleware('admin'), getAllLoans);
router.post('/:loanId/repayments', authMiddleware, addRepayment);

export default router;