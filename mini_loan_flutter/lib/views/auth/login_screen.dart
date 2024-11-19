import 'package:flutter/material.dart';
import 'package:mini_loan_flutter/views/auth/register_screen.dart';
import 'package:mini_loan_flutter/widgets/password_input_field.dart';
import 'package:mini_loan_flutter/widgets/text_input_field.dart';
import 'package:provider/provider.dart';
import 'package:mini_loan_flutter/viewModels/auth_viewmodel.dart';
import '../../utils/constants.dart';
import '../dashboard/admin_dashboard_screen.dart';
import '../dashboard/user_dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'LoginScreen';

  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final authViewModel = Provider.of<AuthViewModel>(context);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Login')),
        body: Column(
          children: [
            // Top Section with Welcome Text and Image
            Container(
              width: double.infinity,
              height: 200,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Welcome!',
                          style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 8.0),
                      Text('Sign in to continue',
                          style: Theme.of(context).textTheme.titleSmall),
                    ],
                  ),
                  Image.asset(
                    'assets/images/placeholder.png',
                    height: 120,
                    width: 120,
                  ),
                ],
              ),
            ),
            // Form Section
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: kOtherColor,
                  borderRadius: kTopBorderRadius,
                ),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 16.0),
                        TextInputField(
                          labelText: 'Email Address',
                          controller: _emailController,
                          validator: (value) {
                            final RegExp regExp = RegExp(emailPattern);
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            } else if (!regExp.hasMatch(value)) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16.0),
                        PasswordInputField(
                          controller: _passwordController,
                          validator: (value) {
                            if (value == null || value.length < 5) {
                              return 'Must be more than 5 characters';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 32.0),
                        authViewModel.isLoading
                            ? const CircularProgressIndicator()
                            : ElevatedButton.icon(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    try {
                                      bool isAdmin = await authViewModel.login(
                                        _emailController.text,
                                        _passwordController.text,
                                      );
                                      if(isAdmin){
                                        Navigator.pushNamedAndRemoveUntil(context, AdminDashboardScreen.routeName, (route) => false);
                                      }else{
                                        Navigator.pushNamedAndRemoveUntil(context, UserDashboardScreen.routeName, (route) => false);
                                      }
                                    } catch (error) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content:
                                                Text('Login failed: $error')),
                                      );
                                    }
                                  }
                                },
                                icon: const Icon(Icons.arrow_forward_outlined),
                                label: const Text('Login'),
                              ),
                        const SizedBox(height: 20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account? ',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                      color: kTextBlackColor,
                                      fontWeight: FontWeight.w500),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushReplacementNamed(
                                    context, RegisterScreen.routeName);
                              },
                              child: Text(
                                'Register here',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                        color: kPrimaryColor,
                                        fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
