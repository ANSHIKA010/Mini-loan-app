import 'package:flutter/material.dart';

class AdminDashboardScreen extends StatelessWidget {

  const AdminDashboardScreen({super.key});

  static String routeName = 'AdminDashboard';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Admin Dashboard"),
      ),
    );
  }
}
