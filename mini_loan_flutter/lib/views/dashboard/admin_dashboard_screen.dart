import 'package:flutter/material.dart';
import 'package:mini_loan_flutter/viewModels/auth_viewmodel.dart';
import 'package:mini_loan_flutter/views/loan/loan_approval_screen.dart';
import 'package:mini_loan_flutter/views/loan/loan_list_screen.dart';
import 'package:provider/provider.dart';
import 'package:mini_loan_flutter/viewModels/admin_viewmodel.dart';

import '../../widgets/loan_card.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  static const String routeName = "AdminDashboardScreen";

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  int _currentIndex = 0;

  // List of screens for navigation
  final List<Widget> _screens = [
    const LoanApprovalScreen(),
    const LoanListScreen(),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AdminViewModel>(context, listen: false).fetchAllLoans();
    });
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout,
              size: 24,
            ),
            onPressed: () {
              // Logout action here
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Logout button pressed')),
              );
            },
          ),
        ],
      ),
      body: _screens[_currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.approval),
            label: 'Pending Approval',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'All Loans',
          ),
        ],
      ),
    );
  }
}
