import 'package:flutter/foundation.dart';
import 'package:mini_loan_flutter/services/api/loan_service.dart';
import '../models/loan_model.dart';
import 'package:mini_loan_flutter/utils/shared_pref.dart';

class UserViewModel extends ChangeNotifier {
  final LoanService _loanService = LoanService();
  bool _isLoading = false;
  List<Loan> loans = [];

  bool get isLoading => _isLoading;

  Future<void> fetchLoans() async {
    _isLoading = true;
    notifyListeners();
    try {
      final userData = await SharedPref.getUserData();
      final token = userData?['token'];
      if (token != null) {
        final response = await _loanService.fetchUserLoans(token);
        loans = response.map((loan) => Loan.fromJson(loan)).toList();
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createLoan(double amount, int term) async {
    _isLoading = true;
    notifyListeners();
    try {
      final userData = await SharedPref.getUserData();
      final token = userData?['token'];
      if (token != null) {
        await _loanService.createLoan(token, {'amount': amount, 'term': term});
        await fetchLoans();
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> makeRepayment(String loanId, double amount) async {
    _isLoading = true;
    notifyListeners();
    try {
      final userData = await SharedPref.getUserData();
      final token = userData?['token'];
      if (token != null) {
        await _loanService.makeRepayment(token, loanId, amount);
        await fetchLoans();
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
