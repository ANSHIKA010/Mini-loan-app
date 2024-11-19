import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // For encoding/decoding JSON

class SharedPref {
  static Future<void> saveLoginData(String token, Map<String, dynamic> user) async {
    final prefs = await SharedPreferences.getInstance();

    // Save token
    await prefs.setString('auth_token', token);

    // Save user data as JSON string
    String userData = jsonEncode(user);
    await prefs.setString('user_data', userData);

  }

  static Future<Map<String, dynamic>?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();

    // Retrieve token and user data
    String? token = prefs.getString('auth_token');
    String? userData = prefs.getString('user_data');

    if (token != null && userData != null) {
      return {
        "token": token,
        "user": jsonDecode(userData), // Convert JSON string back to a map
      };
    }
    return null; // If no data found
  }

  static Future<void> clearAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    await prefs.remove('user_data');
  }

}

