import React, { useState } from 'react';

const RepaymentForm = ({ loanId, onAddRepayment }) => {
    const [amount, setAmount] = useState('');

    const handleRepayment = (e) => {
        e.preventDefault();
        onAddRepayment(loanId, { amount });
        setAmount('');
    };

    return (
        <form onSubmit={handleRepayment}>
            <h5>Make a Repayment</h5>
            <label>
                Repayment Amount:
                <input
                    type="number"
                    min="0.01"
                    step="0.01"
                    value={amount}
                    onChange={(e) => setAmount(e.target.value)}
                    required
                />
            </label>
            <button type="submit">Submit Repayment</button>
        </form>
    );
};

export default RepaymentForm;
