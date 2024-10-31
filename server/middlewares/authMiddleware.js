import jsonwebtoken from 'jsonwebtoken';

const { verify } = jsonwebtoken;

export default (req, res, next) => {
    const authHeader = req.header('Authorization');
    console.log("Auth middleware triggered");

    if (!authHeader) {
        console.warn("Authorization header missing");
        return res.status(401).json({ message: "Access denied" });
    }

    const token = authHeader.startsWith('Bearer ') ? authHeader.slice(7, authHeader.length) : authHeader;
    console.log("Token extracted from header:", token);

    try {
        const decoded = verify(token, process.env.JWT_SECRET);
        console.log("Token verified successfully, user decoded:", decoded);

        req.user = decoded;
        next();
    } catch (error) {
        console.error("Token verification failed:", error.message);
        res.status(400).json({ message: "Invalid token" });
    }
};
