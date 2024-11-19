import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/loan_model.dart';
import '../models/repayment_model.dart';
import '../utils/constants.dart';

class RepaymentCard extends StatelessWidget {
  final Loan loan;

  const RepaymentCard({required this.loan});

  @override
  Widget build(BuildContext context) {

    Repayment pendingRepayment = loan.repayments.firstWhere(
          (repayment) => repayment.status == 'PENDING',
      orElse: () => Repayment(id: "test_id", amount: 100.0, status: "PENDING", dueDate: DateTime(2024)),
    );

    return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Loan ID: ${loan.id}', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('Repayment ID: ${pendingRepayment.id}', style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(
                color: kPrimaryColor,
                fontWeight: FontWeight.w500),
            ),
            Text('Amount: \$${pendingRepayment.amount}'),
            Text('DueDate: ${DateFormat('dd/MM/yyyy').format(pendingRepayment.dueDate)}'),
          ],
        ),
      ),
    );
  }
}
