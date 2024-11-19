import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mini_loan_flutter/utils/constants.dart';

class LoanService {

  Future<List<dynamic>> fetchAllLoans(String token) async {
    print("Start fetch");
    final response = await http.get(
      Uri.parse('$baseUrlLoans/all'),
      headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'},
    );

    print(response.body);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print(response);
      throw Exception('Failed to fetch loans');
    }
  }

  Future<List<dynamic>> fetchUserLoans(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrlLoans/get'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch loans');
    }
  }

  Future<void> createLoan(String token, Map<String, dynamic> loanData) async {
    final response = await http.post(
      Uri.parse('$baseUrlLoans/create'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(loanData),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create loan');
    }
  }

  Future<void> makeRepayment(String token, String loanId, double amount) async {
    final response = await http.post(
      Uri.parse('$baseUrlLoans/$loanId/repayments'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'amount': amount}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to make repayment');
    }
  }
}
