export default role => (req, res, next) => {
    console.log("Role middleware triggered for required role:", role);

    if (req.user && req.user.role === role) {
        console.log("User role matches required role:", req.user.role);
        return next();
    }

    console.warn("Access forbidden: User does not have the required role", {
        userRole: req.user ? req.user.role : "No user role",
        requiredRole: role
    });

    return res.status(403).json({ message: "Access forbidden" });
};
