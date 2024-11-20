# Mini Loan Application

This is a full-stack mini-loan application built with the MERN stack. The backend is powered by Node.js, Express, and MongoDB, while the frontend is developed with React. This application allows users to request loans, make repayments, and view loan details. Admin users can manage and approve loans.

## Table of Contents
- [Features](#features)
- [Deployment](#deployment)
- [Project Structure](#project-structure)
- [Environment Variables](#environment-variables)
- [Installation Guide](#installation-guide)
- [Testing](#testing)
- [Usage](#usage)
- [API Documentation](#api-documentation)
- [Acknowledgments](#acknowledgments)
- [Good To Haves](#good-to-haves)
- [Notes](#notes)

---

## Features

### User Features
- **Registration and Login**: User registration with JWT-based authentication.
- **Loan Requests**: Users can create loan requests specifying the loan amount and term.
- **Repayments**: Users can make repayments, and any overpayments automatically adjust the remaining repayments.

### Admin Features
- **Approve Loans**: Admins can approve or reject loan requests.
- **View All Loans**: Admins can view all loan requests in the system and monitor repayment statuses.

Note: Do consider the notes at the end of the Readme before using and also check additonal notes in each section.

---
## Mobile App Working Demo

<table>
  <tr>
    <td>
      <a href="https://raw.githubusercontent.com/ANSHIKA010/Mini-loan-app/main/assets/demo_video.mp4">
        <img src="https://raw.githubusercontent.com/ANSHIKA010/Mini-loan-app/main/assets/thumbnail.jpg" alt="Watch the video" style="width:100%; max-width:350px;">
      </a>
    </td>
    <td>
      <p>
        <strong>Description</strong><br>
        - First I moved to register screen and registered with email <code>anshika@gmail.com</code> and password as <code>123456</code>.<br>
        - Then I login with the same credentials and get to the user dashboard, where data is not present.<br>
        - I created a loan request with amount 3000 for 3 weeks, which is displayed in all loans sections as it is not approved yet so can't be repaid.<br>
        - Then I login with admin credentials <code>sanshikas010@gmail.com</code> and <code>123456</code> and approved the pending request just created from admin dashboard.<br>
        - Now moving back to the User dashboard where I can now see repayment options.<br>
        - I first paid an amount of 1500 to check for recalculations which can be clearly seen as the remaining repayment amounts are changed accordingly.<br>
        - All the paid repayments are green and pending ones are red.<br>
        - Similarly, I did 2 more repayments with amount of 750 to clear off the loan.<br>
        - All the paid and pending loans and their details are displayed in all loans sections.<br>
        - Finally, I logout from the App.
      </p>
    </td>
  </tr>
</table>


---
## Deployment

#### The server is hosted using [render](https://render.com/)
- The server url is https://mini-loan-app-cjl5.onrender.com
- The Web app url is https://mini-loan-app-1-ot8n.onrender.com/

Note: 
1. I didn't added loaders due to time constraint so please be patient as i hosted this web app using render.com's free service.
2. Please wait few seconds once it log in or any change happen on the screen.
3. Use the below mentioned Admin user credential as UI doesn't have option to create admin credential.

### Test Credentials

#### Admin User

  ```
  username: sanshikas010@gmail.com
  password: 123456
  ```

#### Non-Admin User

  ```
  username: sanshikas@gmail.com
  password: 123456
  ```


---

## Project Structure
Does not include all the files, just for the overview to get an idea about the project directory structure.

```plaintext
root/
│
|
├── mini_loan_flutter
|   ├── main.dart                    # The entry point of the application 
|   |
|   ├── models
|   |   ├── loan_model.dart          # Data model of loan
|   |   ├── repayment_model.dart     # Data model of repayment
|   |   └── user_model.dart          # Data model of User
|   |
|   ├── services
|   |   └── api
|   |       ├── auth_service.dart    # Contains the https requests logic to handle authentication
|   |       └── loan_service.dart    # The api call logic to perform actions on loans data
|   |
|   ├── utils
|   |   ├── constants.dart           # Contants used throughout the app (colors, urls, texts, sizes etc)
|   |   ├── routes.dart              # Contants all the routes of the app
|   |   ├── shared_pref.dart         # Shared pref logic to store token and user data in local storage
|   |   └── theme.dart               # Defining the theme of the app Material
|   |
|   ├── viewModels                   # All the view model files associated with auth admin and user logic
|   |   ├── admin_viewmodel.dart
|   |   ├── auth_viewmodel.dart
|   |   └── user_viewmodel.dart
|   |
|   ├── views                        # The UI screens
|   |   ├── splash_screen.dart
|   |   |
|   |   ├── auth
|   |   |   ├── login_screen.dart
|   |   |   └── register_screen.dart
|   |   |
|   |   ├── dashboard
|   |   |   ├── admin_dashboard_screen.dart
|   |   |   └── user_dashboard_screen.dart
|   |   |
|   |   └── loan
|   |       ├── admin_loan_list_screen.dart
|   |       ├── loan_approval_screen.dart
|   |       ├── loan_repayment_screen.dart
|   |       └── user_loan_list_screen.dart
|   |
|   └── widgets                      # The helper widgets which are reused throught the views
|       ├── default_button.dart
|       ├── detailed_loan_card.dart
|       ├── loan_card.dart
|       ├── password_input_field.dart
|       ├── repayment_card.dart
|       ├── request_card.dart
|       └── text_input_field.dart
|
|
├── server                   # Backend API (Node.js + Express)
│   ├── config               # MongoDB connection setup
│   ├── controllers          # Controllers for handling request logic
│   ├── middlewares          # Authentication and authorization middlewares
│   ├── models               # Mongoose models for User and Loan
│   ├── routes               # API routes for users and loans
│   ├── tests                # Jest and Supertest files for testing
│   ├── server.js            # Main entry point for backend server
│   └── package.json         # Backend dependencies and scripts
│
└── web-app                  # Frontend (React app)
    ├── src                  # Source files for React app
    │   ├── components       # Reusable components (LoanForm, LoanList, etc.)
    │   ├── pages            # Page components (Home, Login, Register, Loans, AdminPanel)
    │   ├── services         # API service functions for auth and loan
    │   ├── utils            # Utilities like PrivateRoute for protecting routes
    │   ├── App.js           # Main App component with routing
    │   ├── index.js         # Entry point for React
    │   └── App.css          # Global styles
    ├── public               # Public assets and HTML template
    └── package.json         # Frontend dependencies and scripts
```
---

## Environment Variables

### Backend (`server/.env`)

Create a `.env` file in the `server` folder and add the following variables:

```plaintext
MONGO_URI=your_mongodb_db_connection_link            # MongoDB connection string
JWT_SECRET=your_jwt_secret                           # JWT secret for token signing
PORT=8000                                            # Server port
```

### Frontend (`web-app/.env`)

Create a `.env` file in the `web-app` folder and add the following:

```plaintext
REACT_APP_API_BASE_URL=http://localhost:8000/api     # Base URL for backend API
```

---

## Installation Guide

### Prerequisites
- **Node.js** and **npm** installed
- **MongoDB** (local or remote connection)

### Step-by-Step Installation

#### 1. Clone the Repository
```bash
git clone https://github.com/ANSHIKA010/mini-loan-app.git
cd mini-loan-app
```

#### 2. Backend (Server) Setup
1. Navigate to the `server` directory:
    ```bash
    cd server
    ```
2. Install the dependencies:
    ```bash
    npm install
    ```
3. Create a `.env` file in the `server` directory and add the following:
    ```plaintext
    MONGO_URI=mongodb://localhost:27017/mini-loan-app  # Replace with your MongoDB URI
    JWT_SECRET=your_jwt_secret                         # Replace with a strong secret for JWT
    PORT=8000                                          # Port for backend server
    ```
4. Start the server:
    ```bash
    npm start
    ```
5. The server should now be running at `http://localhost:8000`.

#### 3. Frontend (React) Setup
1. Open a new terminal and navigate to the `web-app` directory:
    ```bash
    cd ../web-app
    ```
2. Install the dependencies:
    ```bash
    npm install
    ```
3. Create a `.env` file in the `web-app` directory and add:
    ```plaintext
    REACT_APP_API_BASE_URL=http://localhost:8000/api  # Backend API base URL
    ```
4. Start the frontend:
    ```bash
    npm start
    ```
5. The frontend should now be running at `http://localhost:3000`.

Note: yarn.lock is also present if you want to use yarn for build and deploy.

#### 4. Mobile App (Flutter) Setup
1. Open a new terminal and navigate to the `mini_loan_flutter` directory:
    ```bash
    cd ../mini_loan_flutter
    ```
2. Flutter and dart installed correctly, check using doctor command:
    ```bash
    flutter doctor
    ```
3. Connect emulator or physical device to build the app.
4. Get dependencies from pub:
    ```bash
    flutter pub get
    ```
5. Run flutter app
    ```bash
    flutter run
    ```

---

## Testing

### Backend Tests

1. **Run Tests**: Navigate to the `server` folder and run Jest tests.

   ```bash
   cd server
   npm test
   ```

2. **Testing Framework**: The backend uses **Jest** and **Supertest** for unit and integration testing.

---

## API Documentation
The below is the link of Postman API documentation: https://api.postman.com/collections/39344595-4dff3561-4b0c-4e1f-92f5-0345f564d8b8?access_key=PMAT-01JBJYE9P2VGQ893H3QXTH7B87

* Use this link to import the collection in your postman workspace.
* Also checkout [Server Readme](https://github.com/ANSHIKA010/Mini-loan-app/tree/main/server#readme)

---

## Usage

### Accessing the App
- **Frontend**: `http://localhost:3000`
- **Backend API**: `http://localhost:8000/api`
The app is using the backend already hosted on render.com

### Default User Roles
- Users can register directly from the frontend.
- Admin users need to be manually created in MongoDB or given the `isAdmin` flag.

For test purposes api have a param to set admin as true but it is not exposed.

---
## Acknowledgments

- **React**: For creating a great UI library.
- **Express**: For simplifying server setup and API handling.
- **MongoDB**: For flexible data storage.
- **Mongoose**: For schema-based modeling with MongoDB.
- **Nodejs**: For API designing and server side programming.
- **Flutter**: For Mobile App development.

---

## Good to haves:
➢ Include brief documentation for the project: the choices you made and why.
    --> A proper Readme added to describe everything.
         
➢ Use any frontend framework like React, Angular, Svelte or Vue. 
    --> React Used.
    
➢ Use any CSS framework like Material UI, Tailwind, or Bootstrap. 
    --> Global App.css used for styling.
    
➢ Unit and feature tests for frontend and backend. 
    --> wrote unit tests for server and can be tested using 'npm test'.
        
➢ Application should be responsive. Itshould work in both App and Mobile. 
    --> checked for responsiveness on mobile as well.
    
➢ Script to install the app in one go (any tool)
    --> not done
    
➢ Postman collection/open API document for the API
    --> Postman collection link added.
    
➢ Clean application architecture / design patterns
    --> Used standard file structure and code style for simplicity and clearity.
    
➢ Setup CI/CD pipeline using GitHub Actions.
    --> Not done (facing some issues)

---

## Notes
- **Token Expiration**: Tokens are set to expire in 24 hour, after which users must log in again otherwise data would not be visible.
- **Overpayments**: If a user pays more than the scheduled amount, repayments are recalculated for the remaining installments.

---
