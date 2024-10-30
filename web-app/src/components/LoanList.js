import React from 'react';
import RepaymentForm from './RepaymentForm.js';

const LoanList = ({ loans, onAddRepayment }) => {
    return (
        <div>
            <h3>Your Loans</h3>
            {loans.length === 0 ? (
                <p>No loans available.</p>
            ) : (
                loans.map((loan) => (
                    <div key={loan._id} className="loan-item">
                        <h4>Loan ID: {loan._id}</h4>
                        <p>Amount: ${loan.amount}</p>
                        <p>Term: {loan.term} weeks</p>
                        <p>Status: {loan.status}</p>
                        <div>
                            <h5>Repayments:</h5>
                            {loan.repayments.map((repayment, index) => (
                                <p key={index}>
                                    Due Date: {new Date(repayment.dueDate).toLocaleDateString()}, Amount: ${repayment.amount}, Status: {repayment.status}
                                </p>
                            ))}
                        </div>
                        {loan.status !== 'PAID' && (
                            <RepaymentForm loanId={loan._id} onAddRepayment={onAddRepayment} />
                        )}
                    </div>
                ))
            )}
        </div>
    );
};

export default LoanList;
