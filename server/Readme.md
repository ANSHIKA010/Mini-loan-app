# Mini Loan Application Server

This server, built with Node.js, Express, and MongoDB, provides a backend REST API for a Mini Loan Application. It supports functionalities for loan requests, loan approvals by an admin, viewing user-specific loans, making repayments, and viewing all loans (admin-only). The server handles user authentication using JWT, ensuring secure access to loan functionalities.

## Table of Contents
1. [Features](#features)
2. [File Structure](#file-structure)
3. [Installation Guide](#installation-guide)
4. [Environment Variables](#environment-variables)
5. [API Documentation](#api-documentation)
   - [User Authentication](#user-authentication)
   - [Loan Operations](#loan-operations)
6. [Notes](#notes)

---

## Features
- **User Registration and Login**: Allows users to register and log in to receive a JWT token for secure access.
- **Loan Request Creation**: Authenticated users can create loan requests with custom amounts and terms.
- **Admin Approval**: Admins can approve or reject loan requests.
- **User Loan Retrieval**: Users can view only their loans.
- **Admin Loan Retrieval**: Admins can view all loan details in the system.
- **Flexible Repayments**: Users can make repayments, including amounts greater than scheduled repayment, with automatic loan and repayment status updates.

## File Structure

```plaintext
    mini-loan-app
    │
    ├── config
    │   └── db.js              # MongoDB connection setup
    │
    ├── controllers
    │   ├── authController.js  # Authentication-related functions (registration, login)
    │   ├── loanController.js  # Loan-related functions (create, approve, view loans, add repayments)
    │
    ├── middlewares
    │   ├── authMiddleware.js  # Middleware for JWT authentication
    │   └── roleMiddleware.js  # Middleware for admin role authorization
    │
    ├── models
    │   ├── Loan.js            # Mongoose schema and model for loan
    │   └── User.js            # Mongoose schema and model for user
    │
    ├── routes
    │   ├── loanRoutes.js      # Loan-related routes (create loan, approve, view loans, repayments)
    │   └── userRoutes.js      # User-related routes (registration, login)
    │
    ├── utils
    │   └── calculateRepayments.js # Utility function to calculate weekly repayments
    │
    ├── .env                    # Environment variables
    ├── server.js               # App entry point and server configuration
    └── package.json            # Dependencies
```

### Detailed Description of Each File

- **`config/db.js`**: Sets up and initializes a MongoDB connection.
- **`controllers/authController.js`**: Contains user registration and login logic. Uses bcrypt for password hashing and JWT for token generation.
- **`controllers/loanController.js`**: Manages loan functionality, including loan creation, approval by admins, user loan retrieval, repayment submission, and admin-only retrieval of all loans.
- **`middlewares/authMiddleware.js`**: Verifies JWT tokens for secure access to protected routes.
- **`middlewares/roleMiddleware.js`**: Authorizes only admin users to approve loans and view all loans.
- **`models/Loan.js`**: Mongoose schema for loan data, including repayment details, amount, term, and loan status.
- **`models/User.js`**: Mongoose schema for user data, including hashed password and admin status.
- **`routes/loanRoutes.js`**: Defines endpoints for loan-related actions (create loan, approve loan, view loans, add repayments, and admin-only retrieval of all loans).
- **`routes/userRoutes.js`**: Defines endpoints for user actions (register, login).
- **`utils/calculateRepayments.js`**: Helper function to calculate weekly repayment schedule based on the loan amount and term.
- **`server.js`**: Main server file to initialize Express, configure middlewares, and define route entry points.

## Installation Guide

### Prerequisites
- **Node.js** and **npm** installed
- **MongoDB** installed and running locally or on a remote server
- **Git** for version control (optional)

### Steps

1. **Clone the repository**:
    ```bash
    git clone https://github.com/ANSHIKA010/mini-loan-app.git
    cd mini-loan-app/server
    ```

2. **Install dependencies**:
    ```bash
    npm install
    ```

3. **Set up environment variables**:
    Create a `.env` file in the root directory and add the following:
    ```plaintext
    MONGO_URI=mongodb://localhost:27017/mini-loan-app  # Replace with your MongoDB URI
    JWT_SECRET=your_jwt_secret                         # Replace with a strong secret for JWT
    PORT=your_desire_port                              # Replace with desired port number
    ```

4. **Run the server**:
    ```bash
    npm start
    ```
   The server will start on `http://localhost:PORT`.

## Environment Variables

| Variable          | Description                            |
|-------------------|----------------------------------------|
| `MONGO_URI`       | MongoDB connection URI                 |
| `JWT_SECRET`      | Secret key for signing JWT tokens      |
| `PORT`            | Port that you want to use for server   |

## API Documentation

### User Authentication

#### 1. Register User
- **Endpoint**: `POST /api/users/register`
- **Description**: Registers a new user.
- **Request Body**:
    ```json
    {
      "username": "user1",
      "password": "password123"
    }
    ```
- **Response**: 
   ```json
     { "message": "User registered successfully" }
   ```

#### 2. Login User
- **Endpoint**: `POST /api/users/login`
- **Description**: Logs in a user and returns a JWT token.
- **Request Body**:
    ```json
    {
      "username": "user1",
      "password": "password123"
    }
    ```
- **Response**:
    ```json
    {
      "token": "jwt_token_here",
      "user": { "id": "user_id", "username": "user1", "isAdmin": false }
    }
    ```

### Loan Operations

#### 1. Create Loan (User Only)
- **Endpoint**: `POST /api/loans`
- **Description**: Allows a user to request a loan.
- **Headers**: `{ "Authorization": "Bearer <jwt_token>" }`
- **Request Body**:
    ```json
    {
      "amount": 10000,
      "term": 3
    }
    ```
- **Response**:
    ```json
    {
       "user": "user_id",
       "amount": 10000,
       "term": 3,
       "status": "PENDING",
       "repayments": [
           {
               "dueDate": "curr_date+7",
               "amount": 3333.33,
               "status": "PENDING",
               "_id": "repayment_id1"
           },
           {
               "dueDate": "curr_date+14",
               "amount": 3333.33,
               "status": "PENDING",
               "_id": "repayment_id1"
           },
           {
               "dueDate": "curr_date+21",
               "amount": 3333.34,
               "status": "PENDING",
               "_id": "repayment_id1"
           }
       ],
       "_id": "loan_id",
       "__v": 0
   }
    ```

#### 2. Approve Loan (Admin Only)
- **Endpoint**: `PUT /api/loans/:loanId/approve`
- **Description**: Allows an admin to approve a loan.
- **Headers**: `{ "Authorization": "Bearer <jwt_token>" }`
- **Response**:
    ```json
    {
      "message": "Loan approved",
      "loan": { "id": "loan_id", "status": "APPROVED" }
    }
    ```

#### 3. View User Loans (User Only)
- **Endpoint**: `GET /api/loans`
- **Description**: Retrieves loans specific to the authenticated user.
- **Headers**: `{ "Authorization": "Bearer <jwt_token>" }`
- **Response**:
    ```json
    [
      {
        "id": "loan_id",
        "amount": 10000,
        "term": 3,
        "status": "APPROVED",
        "repayments": [...]
      }
    ]
    ```

#### 4. Add Repayment (User Only)
- **Endpoint**: `POST /api/loans/:loanId/repayments`
- **Description**: Allows the user to add a repayment.
- **Headers**: `{ "Authorization": "Bearer <jwt_token>" }`
- **Request Body**:
    ```json
    {
      "amount": 3333.33
    }
    ```
- **Response**:
    ```json
    {
      "message": "Repayment added",
      "loan": { "id": "loan_id", "repayments": [...] }
    }
    ```

#### 5. View All Loans (Admin Only)
- **Endpoint**: `GET /api/loans/all`
- **Description**: Allows an admin to view all loans in the system.
- **Headers**: `{ "Authorization": "Bearer <jwt_token>" }`
- **Response**:
    ```json
    [
      {
        "id": "loan_id",
        "user": "user_id",
        "amount": 10000,
        "term": 3,
        "status": "APPROVED",
        "repayments": [...]
      },
      ...
    ]
    ```

## Notes
- **Overpayments**: If a user repays more than the scheduled amount, the excess amount is applied to the current repayment, but future scheduled repayments remain unchanged.
- **Admin Privileges**: Admins can approve loans and view all loans, but cannot edit loans of other users.
- **Token Expiration**: Tokens are set to expire in 1 hour. Users need to re-authenticate after expiration.
