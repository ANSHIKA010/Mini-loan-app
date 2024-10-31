import bcryptjs from 'bcryptjs';
import jsonwebtoken from 'jsonwebtoken';
import User from '../models/User.js';

const { hash, compare } = bcryptjs;
const { sign } = jsonwebtoken;

// Register a new user
export async function register(req, res) {
    const { username, password, isAdmin } = req.body;
    console.log("Register function called with:", { username, isAdmin });

    try {
        const hashedPassword = await hash(password, 10);
        console.log("Password hashed successfully");

        const user = new User({
            username,
            password: hashedPassword,
            isAdmin: isAdmin || false
        });

        await user.save();
        console.log("New user registered:", { id: user._id, username: user.username });

        res.status(201).json({ message: "User registered successfully" });
    } catch (error) {
        console.error("Error registering user:", error.message);
        res.status(500).json({ error: error.message });
    }
}

// Login an existing user
export async function login(req, res) {
    const { username, password } = req.body;
    console.log("Login function called with:", { username });

    try {
        const user = await User.findOne({ username });
        if (!user) {
            console.warn("User not found for username:", username);
            return res.status(404).json({ message: "User not found" });
        }

        const isMatch = await compare(password, user.password);
        if (!isMatch) {
            console.warn("Password mismatch for username:", username);
            return res.status(400).json({ message: "Invalid credentials" });
        }

        const token = sign({ id: user._id, role: user.isAdmin ? 'admin' : 'user' }, process.env.JWT_SECRET, {
            expiresIn: '24h'
        });
        console.log("Token generated for user:", { id: user._id, role: user.isAdmin ? 'admin' : 'user' });

        res.json({ token, user: { id: user._id, username: user.username, isAdmin: user.isAdmin } });
    } catch (error) {
        console.error("Error logging in user:", error.message);
        res.status(500).json({ error: error.message });
    }
}
