import 'package:flutter/material.dart';

class UserDashboardScreen extends StatelessWidget {
  const UserDashboardScreen({super.key});

  static String routeName = 'UserDashboard';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("User Dashboard"),
      ),
    );
  }
}
