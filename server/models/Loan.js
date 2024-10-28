import { Schema, model } from 'mongoose';

const repaymentSchema = new Schema({
    dueDate: { type: Date, required: true },
    amount: { type: Number, required: true },
    status: { type: String, enum: ['PENDING', 'PAID'], default: 'PENDING' }
});

const loanSchema = new Schema({
    user: { type: Schema.Types.ObjectId, ref: 'User', required: true },
    amount: { type: Number, required: true },
    term: { type: Number, required: true },
    status: { type: String, enum: ['PENDING', 'APPROVED', 'PAID'], default: 'PENDING' },
    repayments: [repaymentSchema]
});

const Loan = model('Loan', loanSchema);

export default Loan;