import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:mini_loan_flutter/services/api/auth_service.dart';
import 'package:mini_loan_flutter/utils/shared_pref.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<bool> login(String username, String password) async {
    _isLoading = true;
    notifyListeners();
    try {
      var loginResponse = await _authService.login(username, password);
      await SharedPref.saveLoginData(
        loginResponse['token'],
        loginResponse['user'],
      );
      return loginResponse['user']['isAdmin'];
    } catch (error) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> register(String username, String password) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _authService.register(username, password);
    } catch (error) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
