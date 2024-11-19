import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/loan_model.dart';
import '../utils/constants.dart';

class DetailedLoanCard extends StatelessWidget {
  final Loan loan;

  const DetailedLoanCard({required this.loan});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Loan ID: ${loan.id}',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text('Amount: \$${loan.amount}'),
            Text('Term: ${loan.term} weeks'),
            Text('Status: ${loan.status}'),
            ExpansionTile(
              title: Text('Repayment Details', style: Theme.of(context).textTheme.titleSmall?.copyWith(color: kTextBlackColor, fontSize: 16,fontWeight: FontWeight.w600)),
              trailing: Icon(Icons.expand_more),
              children: [
                Padding(
                  padding: EdgeInsets.all(4.0),
                  child: ListView.builder(
                    shrinkWrap:
                        true, // Ensures the list fits in the expanded area
                    physics:
                        NeverScrollableScrollPhysics(), // Prevents nested scrolling
                    itemCount: loan.repayments.length,
                    itemBuilder: (context, itemIndex) {
                      return ListTile(
                        title: Text(loan.repayments[itemIndex].id, style: Theme.of(context).textTheme.titleSmall?.copyWith(color: kTextBlackColor),),
                        subtitle: Text('Amount: \$${loan.repayments[itemIndex].amount.toString()}\nPay Date: ${DateFormat('dd/MM/yyyy').format(loan.repayments[itemIndex].dueDate)}'),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
