import axios from 'axios';

const API_URL = `${process.env.REACT_APP_API_BASE_URL}/loans`;

const authHeader = () => ({
    headers: { Authorization: `Bearer ${localStorage.getItem('token')}` }
});

export const createLoan = async (loanData) => {
    return await axios.post(`${API_URL}/create`, loanData, authHeader());
};

export const getUserLoans = async () => {
    return await axios.get(`${API_URL}/get`, authHeader());
};

export const getAllLoans = async () => {
    return await axios.get(`${API_URL}/all`, authHeader());
};

export const approveLoan = async (loanId) => {
    return await axios.put(`${API_URL}/${loanId}/approve`, {}, authHeader());
};

export const addRepayment = async (loanId, repaymentData) => {
    return await axios.post(`${API_URL}/${loanId}/repayments`, repaymentData, authHeader());
};
