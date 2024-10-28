import jsonwebtoken from 'jsonwebtoken';

const { verify } = jsonwebtoken;

export default (req, res, next) => {
    const token = req.header('Authorization');
    if (!token) return res.status(401).json({ message: "Access denied" });
    console.log(token);
    try {
        const decoded = verify(token, process.env.JWT_SECRET);
        req.user = decoded;
        next();
    } catch (error) {
        console.error(error);
        res.status(400).json({ message: "Invalid token" });
    }
};