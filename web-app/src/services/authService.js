import axios from 'axios';


const API_URL = `${process.env.REACT_APP_API_BASE_URL}/users`;

 
export const register = async (userData) => {
    return await axios.post(`${API_URL}/register`, userData);
};

export const login = async (userData) => {
    console.log(userData);
    const response = await axios.post(`${API_URL}/login`, userData);
    if (response.data.token) {
        localStorage.setItem('token', response.data.token);
    }
    return response.data;
};

export const logout = () => {
    localStorage.removeItem('token');
};
