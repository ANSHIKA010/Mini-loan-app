import bcryptjs from 'bcryptjs';
import jsonwebtoken from 'jsonwebtoken';
import User from '../models/User.js';


const { hash, compare } = bcryptjs;
const { sign } = jsonwebtoken;

// Register a new user
export async function register(req, res) {
    const { username, password, isAdmin } = req.body;

    try {
        const hashedPassword = await hash(password, 10);
        const user = new User({
            username,
            password: hashedPassword,
            isAdmin: isAdmin || false
        });

        await user.save();
        res.status(201).json({ message: "User registered successfully" });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
}

// Login an existing user
export async function login(req, res) {
    const { username, password } = req.body;

    try {
        const user = await User.findOne({ username });
        if (!user) return res.status(404).json({ message: "User not found" });

        const isMatch = await compare(password, user.password);
        if (!isMatch) return res.status(400).json({ message: "Invalid credentials" });
        const token = sign({ id: user._id, role: user.isAdmin ? 'admin' : 'user' }, process.env.JWT_SECRET, {
            expiresIn: '1h'
        });

        res.json({ token, user: { id: user._id, username: user.username, isAdmin: user.isAdmin } });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
}
