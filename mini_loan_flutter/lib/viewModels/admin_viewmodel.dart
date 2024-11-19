import 'package:flutter/foundation.dart';
import '../services/api/loan_service.dart';
import '../models/loan_model.dart';
import '../utils/shared_pref.dart';

class AdminViewModel extends ChangeNotifier {

  final LoanService _loanService = LoanService();
  bool _isLoading = false;
  List<Loan> loans = [];

  bool get isLoading => _isLoading;

  Future<void> fetchAllLoans() async {
    _isLoading = true;
    print("Function called");
    notifyListeners();
    try {
      final userData = await SharedPref.getUserData();
      final token = userData?['token'];
      print(token);
      if (token != null) {
        final response = await _loanService.fetchAllLoans(token);
        print(response);
        loans = response.map((loan) => Loan.fromJson(loan)).toList();
      }
    }catch(error){
      print("Loan Get error: "+error.toString());
    }finally {
      _isLoading = false;
      notifyListeners();
    }
  }

}
