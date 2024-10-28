import Loan from '../models/Loan.js';
import calculateRepayments from '../utils/calculateRepayments.js';

// Create a loan request
export async function createLoan(req, res) {
    const { amount, term } = req.body;
    const user = req.user.id;

    try {
        const repayments = calculateRepayments(amount, term);
        const loan = await Loan.create({ user, amount, term, repayments });
        res.status(201).json(loan);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
}

// Approve loan (Admin)
export async function approveLoan(req, res) {
    try {
        const loan = await Loan.findByIdAndUpdate(req.params.loanId, { status: 'APPROVED' }, { new: true });
        res.status(200).json(loan);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
}

// Get loans of authenticated user
export async function getUserLoans(req, res) {
    try {
        const loans = await Loan.find({ user: req.user.id });
        res.status(200).json(loans);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
}

// Get all loans to display for admin
export async function getAllLoans(req, res) {
    try {
        const loans = await Loan.find();
        res.status(200).json(loans);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
}

// Make repayment
export async function addRepayment(req, res) {
    try {
        const loan = await Loan.findById(req.params.loanId);
        const repayment = loan.repayments.find(r => r.status === 'PENDING');

        if (repayment) {
            repayment.status = 'PAID';
            loan.status = loan.repayments.every(r => r.status === 'PAID') ? 'PAID' : loan.status;
            await loan.save();
            res.status(200).json(loan);
        } else {
            res.status(400).json({ message: "No pending repayments" });
        }
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
}
