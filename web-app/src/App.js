import './App.css';
import React from 'react';
import { BrowserRouter as Router, Route, Routes } from 'react-router-dom';
import Home from './pages/Home.js';
import Login from './pages/Login.js';
import Register from './pages/Register.js';
import Loans from './pages/Loans.js';
import AdminPanel from './pages/AdminPanel.js';
import PrivateRoute from './utils/PrivateRoute';

function App() {
    return (
        <Router>
            <div className="App">
                <Routes>
                    <Route path="/" element={<Home />} />
                    <Route path="/login" element={<Login />} />
                    <Route path="/register" element={<Register />} />
                    <Route path="/loans" element={<PrivateRoute component={Loans} />} />
                    <Route path="/admin" element={<PrivateRoute component={AdminPanel} />} />
                </Routes>
            </div>
        </Router>
    );
}

export default App;

