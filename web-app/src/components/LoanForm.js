import React, { useState } from 'react';

const LoanForm = ({ onCreateLoan }) => {
    const [amount, setAmount] = useState('');
    const [term, setTerm] = useState('');

    const handleSubmit = (e) => {
        e.preventDefault();
        onCreateLoan({ amount, term });
        setAmount('');
        setTerm('');
    };

    return (
        <form onSubmit={handleSubmit}>
            <h3>Request a Loan</h3>
            <label>
                Loan Amount:
                <input
                    type="number"
                    min="0.01"
                    step="0.01"
                    value={amount}
                    onChange={(e) => setAmount(e.target.value)}
                    required
                />
            </label>
            <label>
                Loan Term (weeks):
                <input
                    type="number"
                    min="0.01"
                    step="0.01"
                    value={term}
                    onChange={(e) => setTerm(e.target.value)}
                    required
                />
            </label>
            <button type="submit">Submit Loan Request</button>
        </form>
    );
};

export default LoanForm;
