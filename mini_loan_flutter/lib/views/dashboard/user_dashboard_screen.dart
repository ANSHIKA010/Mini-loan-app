import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mini_loan_flutter/viewModels/auth_viewmodel.dart';
import 'package:provider/provider.dart';
import '../../utils/constants.dart';
import '../../viewModels/user_viewmodel.dart';
import '../../widgets/loan_card.dart';
import 'package:mini_loan_flutter/views/loan/user_loan_list_screen.dart';
import 'package:mini_loan_flutter/views/loan/loan_repayment_screen.dart';

import '../../widgets/text_input_field.dart';
import '../auth/login_screen.dart';

class UserDashboardScreen extends StatefulWidget {
  static const String routeName = 'UserDashboardScreen';

  @override
  State<UserDashboardScreen> createState() => _UserDashboardScreenState();
}

class _UserDashboardScreenState extends State<UserDashboardScreen> {
  int _currentIndex = 0;

  // List of screens for navigation
  final List<Widget> _screens = [
    const LoanRepaymentScreen(),
    const UserLoanListScreen(),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserViewModel>(context, listen: false).fetchLoans();
    });
  }

  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context);
    final authViewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Dashboard'),
        actions: [
          IconButton(
            icon: userViewModel.isLoading
                ? const Icon(
                    Icons.stop,
                    size: 24,
                  )
                : const Icon(
                    Icons.logout,
                    size: 24,
                  ),
            onPressed: () async {
              // Logout action here
              await authViewModel.logout();
              Navigator.pushNamedAndRemoveUntil(
                  context, LoginScreen.routeName, (route) => false);
            },
          ),
        ],
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.money_off),
            label: 'Repayments',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'All Loans',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showBottomSheet(context);
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

void _showBottomSheet(BuildContext context) {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _loanAmountController = TextEditingController();
  final TextEditingController _weekCountController = TextEditingController();
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
            Text('Request Loan', style: Theme.of(context).textTheme.titleMedium),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Loan Amount',
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
                  const SizedBox(height: 16.0),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Duration (in Weeks)',
                      labelStyle: TextStyle(color: kTextWhiteColor),
                    ),
                    cursorColor: kTextWhiteColor,
                    controller: _weekCountController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Must be more than 5 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 32.0),
                  ElevatedButton.icon(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          //
                          userViewModel.createLoan(double.tryParse(_loanAmountController.text)!, int.tryParse(_weekCountController.text)!);
                          Navigator.pop(context);
                        } catch (error) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text('Adding Loan failed: $error')),
                          );
                        }
                      }
                    },
                    label: const Text('Request'),
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
