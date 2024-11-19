import 'package:flutter/material.dart';
import 'package:mini_loan_flutter/widgets/repayment_card.dart';
import 'package:provider/provider.dart';

import '../../viewModels/user_viewmodel.dart';

class LoanRepaymentScreen extends StatefulWidget {
  const LoanRepaymentScreen({super.key});

  @override
  State<LoanRepaymentScreen> createState() => _LoanRepaymentScreenState();
}

class _LoanRepaymentScreenState extends State<LoanRepaymentScreen> {
  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context);
    final pendingLoans =
        userViewModel.loans.where((loan) => loan.status == "APPROVED").toList();

    return Scaffold(
      body: userViewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : pendingLoans.isEmpty
              ? const Center(child: Text('No Pending Repayments.'))
              : ListView.builder(
                  itemCount: pendingLoans.length,
                  itemBuilder: (context, index) {
                    return RepaymentCard(loan: pendingLoans[index]);
                  },
                ),
    );
  }
}
