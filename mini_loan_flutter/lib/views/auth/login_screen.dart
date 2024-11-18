import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mini_loan_flutter/viewModels/auth_viewmodel.dart';

class LoginScreen extends StatelessWidget {

  static String routeName = 'LoginScreen';
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final authViewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            authViewModel.isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
              onPressed: () async {
                try {
                  await authViewModel.login(
                    usernameController.text,
                    passwordController.text,
                  );
                  Navigator.pushReplacementNamed(context, '/home');
                } catch (error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Login failed: $error')),
                  );
                }
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
