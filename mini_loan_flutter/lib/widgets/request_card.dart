import 'package:flutter/material.dart';
import '../models/loan_model.dart';
import 'default_button.dart';

class RequestCard extends StatelessWidget {
  final Loan loan;
  final void Function(String) onButtonPress;

  const RequestCard({required this.loan, required this.onButtonPress});

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
            const SizedBox(height: 16.0),
            Align(
              alignment: Alignment.center,
              child: DefaultButton(title: "Approve", onPress: (){onButtonPress(loan.id);}, iconData: Icons.approval,),
            )
          ],
        ),
      ),
    );
  }
}
