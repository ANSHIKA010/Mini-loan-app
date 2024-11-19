import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mini_loan_flutter/utils/constants.dart';
import 'package:mini_loan_flutter/widgets/repayment_card.dart';
import 'package:provider/provider.dart';

import '../../models/loan_model.dart';
import '../../models/repayment_model.dart';
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
          ? const Center(child: CircularProgressIndicator(color: kTextWhiteColor,))
          : pendingLoans.isEmpty
              ? const Center(child: Text('No Pending Repayments.'))
              : ListView.builder(
                  itemCount: pendingLoans.length,
                  itemBuilder: (context, index) {
                    return RepaymentCard(loan: pendingLoans[index], onButtonPress: _showBottomSheetForRepayment,);
                  },
                ),
    );
  }
}


void _showBottomSheetForRepayment(BuildContext context, Loan loan, Repayment pendingRepayment) {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _loanAmountController = TextEditingController();
  final userViewModel = Provider.of<UserViewModel>(context, listen: false);

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    backgroundColor: kSecondaryColor,
    builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        ),
        child: Wrap(
          children: [
            Center(
              child: Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Text('Make Repayment', style: Theme.of(context).textTheme.titleMedium),
            Text(
              'Repayment ID: ${pendingRepayment.id}',
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!,
            ),
            Text(
              'Amount: \$${pendingRepayment.amount}',
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
            ),
            const SizedBox(height: 16.0),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Enter Repayment Amount',
                      labelStyle: TextStyle(color: kTextWhiteColor),
                    ),
                    controller: _loanAmountController,
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 32.0),
                  ElevatedButton.icon(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          userViewModel.makeRepayment(loan.id, double.tryParse(_loanAmountController.text)!);
                          Navigator.pop(context);
                        } catch (error) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text('Adding Loan failed: $error')),
                          );
                        }
                      }
                    },
                    icon: Icon(Icons.payments),
                    label: const Text('Submit'),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}
