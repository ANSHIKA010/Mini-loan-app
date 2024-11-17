import 'package:mini_loan_flutter/views/auth/login_screen.dart';
import 'package:mini_loan_flutter/views/splash_screen.dart';
import 'package:flutter/material.dart';


Map<String, WidgetBuilder> routes = {
  //all screens will be registered here
  SplashScreen.routeName: (context) => SplashScreen(),
  LoginScreen.routeName: (context) => LoginScreen(),
};