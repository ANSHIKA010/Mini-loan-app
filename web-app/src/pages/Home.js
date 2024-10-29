import React from 'react';
import { Link } from 'react-router-dom';

const Home = () => {
    return (
        <div className="home-container">
            <h1>Welcome to the Mini Loan App</h1>
            <p>Manage your loan applications, repayments, and track your loan status easily.</p>
            <div className="home-links">
                <Link to="/login" className="button">Login</Link>
                <Link to="/register" className="button">Register</Link>
            </div>
        </div>
    );
};

export default Home;
