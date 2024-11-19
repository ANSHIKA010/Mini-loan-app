import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewModels/admin_viewmodel.dart';
import '../../widgets/loan_card.dart';

class LoanListScreen extends StatefulWidget {
  const LoanListScreen({super.key});

  @override
  State<LoanListScreen> createState() => _LoanListScreenState();
}

class _LoanListScreenState extends State<LoanListScreen> {
  @override
  Widget build(BuildContext context) {
    final adminViewModel = Provider.of<AdminViewModel>(context);
    final pendingLoans = adminViewModel.loans.where((loan) => loan.status != "PENDING").toList();

    return Scaffold(
      body: adminViewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : pendingLoans.isEmpty
          ? const Center(child: Text('No loans available.'))
          : ListView.builder(
        itemCount: pendingLoans.length,
        itemBuilder: (context, index) {
          return LoanCard(loan:pendingLoans[index]);
        },
      ),
    );
  }
}
