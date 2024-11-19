import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewModels/user_viewmodel.dart';
import '../../widgets/loan_card.dart';

class UserLoanListScreen extends StatefulWidget {
  const UserLoanListScreen({super.key});

  @override
  State<UserLoanListScreen> createState() => _UserLoanListScreenState();
}

class _UserLoanListScreenState extends State<UserLoanListScreen> {
  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context);
    final pendingLoans =
        userViewModel.loans.where((loan) => loan.status != "APPROVED").toList();

    return Scaffold(
      body: userViewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : pendingLoans.isEmpty
              ? const Center(child: Text('No loans available.'))
              : ListView.builder(
                  itemCount: pendingLoans.length,
                  itemBuilder: (context, index) {
                    return LoanCard(loan: pendingLoans[index]);
                  },
                ),
    );
  }
}
