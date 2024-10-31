import React, { useEffect, useState } from 'react';
import { createLoan, getUserLoans, addRepayment } from '../services/loanService';
import LoanForm from '../components/LoanForm';
import LoanList from '../components/LoanList';
import { useNavigate } from 'react-router-dom';

const Loans = () => {
    const [loans, setLoans] = useState([]);
    const navigate = useNavigate();

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

    const handleLogout = () => {
        localStorage.clear(); 
        navigate('/login'); 
    };

    return (
        <div className='page'>
            <div className='page-header'>
                <h2>Your Loans</h2>
                <button onClick={handleLogout}>Logout</button>
            </div>
            <LoanForm onCreateLoan={handleCreateLoan} />
            <LoanList loans={loans} onAddRepayment={handleAddRepayment} />
        </div>
    );
};

export default Loans;
