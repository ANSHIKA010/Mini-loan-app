import 'package:flutter/material.dart';
import '../models/loan_model.dart';

class LoanCard extends StatelessWidget {
  final Loan loan;

  const LoanCard({required this.loan});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Loan ID: ${loan.id}', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('Amount: \$${loan.amount}'),
            Text('Term: ${loan.term} weeks'),
            Text('Status: ${loan.status}'),
          ],
        ),
      ),
    );
  }
}
