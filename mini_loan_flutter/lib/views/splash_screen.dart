import 'package:flutter/material.dart';
import 'package:mini_loan_flutter/utils/shared_pref.dart';
import 'package:mini_loan_flutter/views/dashboard/admin_dashboard_screen.dart';
import 'package:mini_loan_flutter/views/dashboard/user_dashboard_screen.dart';
import 'package:mini_loan_flutter/views/auth/login_screen.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = 'SplashScreen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(Duration(seconds: 5));
    try {
      Map<String, dynamic>? userData = await SharedPref.getUserData();
      if (userData != null && userData["token"] != null) {
        if (userData["user"]["isAdmin"]) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            AdminDashboardScreen.routeName,
                (route) => false,
          );
        } else {
          Navigator.pushNamedAndRemoveUntil(
            context,
            UserDashboardScreen.routeName,
                (route) => false,
          );
        }
      } else {
        Navigator.pushNamedAndRemoveUntil(
          context,
          LoginScreen.routeName,
              (route) => false,
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error during navigation: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Mini', style: Theme.of(context).textTheme.headlineSmall),
                Text('Loan', style: Theme.of(context).textTheme.headlineSmall),
              ],
            ),
            Image.asset(
              'assets/images/placeholder.png',
              height: 25.h,
              width: 50.w,
            ),
          ],
        ),
      ),
    );
  }
}
