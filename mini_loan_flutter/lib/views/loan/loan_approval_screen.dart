import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:mini_loan_flutter/viewModels/admin_viewmodel.dart';

import '../../widgets/loan_card.dart';
import '../../widgets/request_card.dart';

class LoanApprovalScreen extends StatefulWidget {
  const LoanApprovalScreen({super.key});

  @override
  State<LoanApprovalScreen> createState() => _LoanApprovalScreenState();
}

class _LoanApprovalScreenState extends State<LoanApprovalScreen> {
  @override
  Widget build(BuildContext context) {
    final adminViewModel = Provider.of<AdminViewModel>(context);
    final pendingLoans =
        adminViewModel.loans.where((loan) => loan.status == "PENDING").toList();

    void _approveLoan(String loanId) async {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Approving $loanId')),
      );
      await adminViewModel.approveLoan(loanId);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Approved')),
      );
    }

    return Scaffold(
      body: adminViewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : pendingLoans.isEmpty
              ? Center(child: Text('No Pending requests.', style: Theme.of(context).textTheme.titleSmall))
              : ListView.builder(
                  itemCount: pendingLoans.length,
                  itemBuilder: (context, index) {
                    return RequestCard(
                      loan: pendingLoans[index],
                      onButtonPress: _approveLoan,
                    );
                  },
                ),
    );
  }
}
