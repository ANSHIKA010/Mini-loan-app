import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mini_loan_flutter/widgets/default_button.dart';
import '../models/loan_model.dart';
import '../models/repayment_model.dart';
import '../utils/constants.dart';

class RepaymentCard extends StatelessWidget {
  final Loan loan;


  final void Function(BuildContext, Loan, Repayment) onButtonPress;

  const RepaymentCard({required this.loan, required this.onButtonPress});

  @override
  Widget build(BuildContext context) {
    Repayment pendingRepayment = loan.repayments.firstWhere(
      (repayment) => repayment.status == 'PENDING',
      orElse: () => Repayment(
          id: "test_id",
          amount: 100.0,
          status: "PENDING",
          dueDate: DateTime(2024)),
    );

    return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Loan ID: ${loan.id}',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text('Loan Amount: ${loan.amount}'),
            Text('Loan Duration: ${loan.term} weeks'),
            Padding(padding: EdgeInsets.only(top: 10.0, bottom: 6.0), child: Text('Upcoming Repayment', style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: kPrimaryColor, fontSize: 18),
            ),),
            Text(
              'Repayment ID: ${pendingRepayment.id}',
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: kPrimaryColor, fontWeight: FontWeight.w500),
            ),
            Text(
              'Amount: \$${pendingRepayment.amount}',
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: kPrimaryColor, fontWeight: FontWeight.w500),
            ),
            Text(
              'DueDate: ${DateFormat('dd/MM/yyyy').format(pendingRepayment.dueDate)}',
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: kPrimaryColor, fontWeight: FontWeight.w500),
            ),
            ExpansionTile(
              title: Text('All Repayments Detail', style: Theme.of(context).textTheme.titleSmall?.copyWith(color: kTextBlackColor, fontSize: 14,fontWeight: FontWeight.w600)),
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
                        title: Text(loan.repayments[itemIndex].id, style: Theme.of(context).textTheme.titleSmall?.copyWith(color: kTextWhiteColor),),
                        subtitle: Text('Amount: \$${loan.repayments[itemIndex].amount.toString()}\nPay Date: ${DateFormat('dd/MM/yyyy').format(loan.repayments[itemIndex].dueDate)}'),
                        tileColor: (loan.repayments[itemIndex].status == 'PAID')? Colors.green: Colors.red,
                        subtitleTextStyle: Theme.of(context).textTheme.bodySmall?.copyWith(color: kTextWhiteColor),
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Align(
              alignment: Alignment.center,
              child: DefaultButton(
                title: "Make Repayment",
                onPress: () {onButtonPress(context, loan, pendingRepayment);},
                iconData: Icons.payments,
              ),
            )
          ],
        ),
      ),
    );
  }
}
