import React, { useState } from 'react';
import { login } from '../services/authService.js';
import { useNavigate } from 'react-router-dom';

const Login = () => {
    const [username, setUsername] = useState('');
    const [password, setPassword] = useState('');
    const navigate = useNavigate();

    const handleLogin = async (e) => {
        
        e.preventDefault();
        try {
            const userdata = await login({ username, password });
            if(userdata.user.isAdmin) navigate('/admin');
            else navigate('/loans');
        } catch (error) {
            if(error.name==='AxiosError') console.error(error.response.data.message);
            else console.error(error);
        }
    };

    return (
        <div className='page'>
            <h2>Login</h2>
            <form onSubmit={handleLogin}>
                <input type="text" placeholder="Username" onChange={(e) => setUsername(e.target.value)} required />
                <input type="password" placeholder="Password" onChange={(e) => setPassword(e.target.value)} required />
                <button type="submit">Login</button>
            </form>
        </div>
    );
};

export default Login;
