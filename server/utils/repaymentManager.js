function formatNumberWithoutRounding(num, decimalPlaces) {
    const factor = Math.pow(10, decimalPlaces);
    return Math.floor(num * factor) / factor; 
}

export async function calculateRepayments(amount, term) {
    console.log("calculateRepayments called with:", { amount, term });
    
    const weeklyAmount = formatNumberWithoutRounding((amount / term), 2);
    console.log("Calculated weeklyAmount:", weeklyAmount);
    
    const repayments = [];
    
    for (let i = 1; i <= term; i++) {
        const dueDate = new Date();
        dueDate.setDate(dueDate.getDate() + (7 * i));
        
        const repaymentAmount = i === term ? (amount - (weeklyAmount * (term - 1))) : weeklyAmount;
        repayments.push({ dueDate, amount: repaymentAmount });
        
        console.log(`Installment ${i}:`, { dueDate, amount: repaymentAmount });
    }
    
    console.log("Final repayments array:", repayments);
    return repayments;
}

export async function adjustRepayments(remainingBalance, totalInstallmentsRemained, repayments) {
    console.log("adjustRepayments called with:", { remainingBalance, totalInstallmentsRemained, repayments });
    
    const weeklyAmount = formatNumberWithoutRounding((remainingBalance / totalInstallmentsRemained), 2);
    console.log("Calculated new weeklyAmount for adjustment:", weeklyAmount);
    
    let counter = 1;

    repayments.forEach((repayment) => {
        if (repayment.status === 'PENDING') {
            const repaymentAmount = counter === totalInstallmentsRemained ? 
            formatNumberWithoutRounding((remainingBalance - (weeklyAmount * (totalInstallmentsRemained - 1))),2) : weeklyAmount;
                
            repayment.amount = repaymentAmount;
            console.log(`Adjusted repayment for installment ${counter}:`, { repayment });

            counter++;
        }
    });

    console.log("Adjusted repayments array:", repayments);
    return repayments;
}
