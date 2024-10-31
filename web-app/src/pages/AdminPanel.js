import React, { useEffect, useState } from 'react';
import { getAllLoans, approveLoan } from '../services/loanService';
import { useNavigate } from 'react-router-dom';

const AdminPanel = () => {
    const [loans, setLoans] = useState([]);
    const navigate = useNavigate();

    useEffect(() => {
        fetchAllLoans();
    }, []);

    const fetchAllLoans = async () => {
        try {
            const response = await getAllLoans();
            setLoans(response.data);
        } catch (error) {
            console.error("Error fetching all loans:", error.response?.data || error.message);
        }
    };

    const handleApproveLoan = async (loanId) => {
        try {
            await approveLoan(loanId);
            fetchAllLoans();
        } catch (error) {
            console.error("Error approving loan:", error.response?.data || error.message);
        }
    };

    const handleLogout = () => {
        localStorage.clear(); 
        navigate('/login'); 
    };

    return (
        <div className='page'>
            <div className='page-header'>
                <h2>Admin Panel - Manage Loans</h2>
                <button onClick={handleLogout}>Logout</button>
            </div>
            {loans.length === 0 ? (
                <p>No loans available.</p>
            ) : (
                loans.map((loan) => (
                    <div key={loan.id} className="loan-item">
                        <h4>Loan ID: {loan._id}</h4>
                        <p>Customer ID: {loan.user}</p>
                        <p>Amount: ${loan.amount}</p>
                        <p>Term: {loan.term} weeks</p>
                        <p>Status: {loan.status}</p>
                        {loan.status === 'PENDING' && (
                            <button onClick={() => handleApproveLoan(loan._id)}>Approve Loan</button>
                        )}
                        <div>
                            <h5>Repayments:</h5>
                            {loan.repayments.map((repayment, index) => (
                                <p key={index}>
                                    Due Date: {new Date(repayment.dueDate).toLocaleDateString()}, Amount: ${repayment.amount}, Status: {repayment.status}
                                </p>
                            ))}
                        </div>
                    </div>
                ))
            )}
        </div>
    );
};

export default AdminPanel;
