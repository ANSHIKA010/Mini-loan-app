function calculateRepayments(amount, term) {
    const weeklyAmount = (amount / term).toFixed(2);
    const repayments = [];
    
    for (let i = 1; i <= term; i++) {
        const dueDate = new Date();
        dueDate.setDate(dueDate.getDate() + (7 * i));
        repayments.push({ dueDate, amount: i === term ? (amount - (weeklyAmount * (term - 1))) : weeklyAmount });
    }

    return repayments;
}

export default calculateRepayments;