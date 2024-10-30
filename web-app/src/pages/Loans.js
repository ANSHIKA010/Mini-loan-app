import React, { useEffect, useState } from 'react';
import { createLoan, getUserLoans, addRepayment } from '../services/loanService';
import LoanForm from '../components/LoanForm';
import LoanList from '../components/LoanList';

const Loans = () => {
    const [loans, setLoans] = useState([]);

    useEffect(() => {
        fetchLoans();
    }, []);

    const fetchLoans = async () => {
        try {
            const response = await getUserLoans();
            setLoans(response.data);
        } catch (error) {
            console.error("Error fetching loans:", error.response?.data || error.message);
        }
    };

    const handleCreateLoan = async (loanData) => {
        try {
            await createLoan(loanData);
            fetchLoans();
        } catch (error) {
            console.error("Error creating loan:", error.response?.data || error.message);
        }
    };

    const handleAddRepayment = async (loanId, repaymentData) => {
        try {
            await addRepayment(loanId, repaymentData);
            fetchLoans();
        } catch (error) {
            console.error("Error adding repayment:", error.response?.data || error.message);
        }
    };

    return (
        <div>
            <h2>Your Loans</h2>
            <LoanForm onCreateLoan={handleCreateLoan} />
            <LoanList loans={loans} onAddRepayment={handleAddRepayment} />
        </div>
    );
};

export default Loans;
