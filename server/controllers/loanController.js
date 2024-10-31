import Loan from '../models/Loan.js';
import { calculateRepayments, adjustRepayments } from '../utils/repaymentManager.js';

// Create a loan request
export async function createLoan(req, res) {
    const { amount, term } = req.body;
    const user = req.user.id;
    console.log("createLoan called with:", { user, amount, term });

    try {
        const repayments = await calculateRepayments(amount, term);
        console.log("Calculated repayments:", repayments);

        const loan = await Loan.create({ user, amount, term, repayments });
        console.log("Loan created successfully:", loan);

        res.status(201).json(loan);
    } catch (error) {
        console.error("Error creating loan:", error.message);
        res.status(500).json({ error: error.message });
    }
}

// Approve loan (Admin)
export async function approveLoan(req, res) {
    console.log("approveLoan called with loanId:", req.params.loanId);

    try {
        const loan = await Loan.findByIdAndUpdate(req.params.loanId, { status: 'APPROVED' }, { new: true });
        console.log("Loan approved:", loan);

        res.status(200).json(loan);
    } catch (error) {
        console.error("Error approving loan:", error.message);
        res.status(500).json({ error: error.message });
    }
}

// Get loans of authenticated user
export async function getUserLoans(req, res) {
    console.log("getUserLoans called for user:", req.user.id);

    try {
        const loans = await Loan.find({ user: req.user.id });
        console.log("User loans retrieved:", loans);

        res.status(200).json(loans);
    } catch (error) {
        console.error("Error fetching user loans:", error.message);
        res.status(500).json({ error: error.message });
    }
}

// Get all loans to display for admin
export async function getAllLoans(req, res) {
    console.log("getAllLoans called by admin");

    try {
        const loans = await Loan.find();
        console.log("All loans retrieved:", loans);

        res.status(200).json(loans);
    } catch (error) {
        console.error("Error fetching all loans:", error.message);
        res.status(500).json({ error: error.message });
    }
}

// Make repayment
export async function addRepayment(req, res) {
    const { amount } = req.body;
    console.log("addRepayment called with:", { loanId: req.params.loanId, amount });

    try {
        const loan = await Loan.findById(req.params.loanId);
        console.log("Loan found for repayment:", loan);

        const repayment = loan.repayments.find(r => r.status === 'PENDING');
        console.log("Pending repayment found:", repayment);

        const { remainingBalance, pendingRepaymentsNum } = loan.repayments.reduce((acc, repayment) => {
                if (repayment.status === 'PENDING') {
                    acc.remainingBalance += repayment.amount;
                    acc.pendingRepaymentsNum += 1;
                }
                return acc;
            },
            { remainingBalance: 0, pendingRepaymentsNum: 0 }
        );
        console.log("Remaining balance and pending repayments calculated:", { remainingBalance, pendingRepaymentsNum });

        if (repayment && amount <= remainingBalance) {
            repayment.status = 'PAID';
            repayment.amount = amount;
            console.log("Repayment updated as paid:", repayment);

            loan.repayments = await adjustRepayments(remainingBalance - amount, pendingRepaymentsNum - 1, loan.repayments);
            console.log("Repayments adjusted after payment:", loan.repayments);

            loan.status = loan.repayments.every(r => r.status === 'PAID' || r.amount === 0) ? 'PAID' : loan.status;
            console.log("Loan status updated:", loan.status);

            await loan.save();
            console.log("Loan saved after repayment:", loan);

            res.status(200).json(loan);
        } else if (!repayment) {
            console.warn("No pending repayments for loan:", req.params.loanId);
            res.status(400).json({ message: "No pending repayments" });
        } else {
            console.warn("Invalid repayment amount:", { amount, remainingBalance });
            res.status(400).json({ message: "Invalid repayment amount" });
        }

    } catch (error) {
        console.error("Error adding repayment:", error.message);
        res.status(500).json({ error: error.message });
    }
}
