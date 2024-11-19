import 'package:mini_loan_flutter/views/auth/login_screen.dart';
import 'package:mini_loan_flutter/views/auth/register_screen.dart';
import 'package:mini_loan_flutter/views/splash_screen.dart';
import 'package:flutter/material.dart';

import '../views/dashboard/admin_dashboard_screen.dart';
import '../views/dashboard/user_dashboard_screen.dart';


Map<String, WidgetBuilder> routes = {
  //all screens will be registered here
  SplashScreen.routeName: (context) => SplashScreen(),
  LoginScreen.routeName: (context) => LoginScreen(),
  RegisterScreen.routeName: (context) => RegisterScreen(),
  AdminDashboardScreen.routeName: (context) => AdminDashboardScreen(),
  UserDashboardScreen.routeName: (context) => UserDashboardScreen(),
};