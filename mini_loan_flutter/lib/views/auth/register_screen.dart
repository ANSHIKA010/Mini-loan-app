import 'package:flutter/material.dart';
import 'package:mini_loan_flutter/views/auth/login_screen.dart';
import 'package:mini_loan_flutter/widgets/password_input_field.dart';
import 'package:mini_loan_flutter/widgets/text_input_field.dart';
import 'package:provider/provider.dart';
import 'package:mini_loan_flutter/viewModels/auth_viewmodel.dart';
import '../../utils/constants.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'RegisterScreen';

  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
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
        appBar: AppBar(title: const Text('Register')),
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
                      Text('Enter Details to register',
                          style: Theme.of(context).textTheme.titleSmall),
                    ],
                  ),
                  Image.asset(
                    'assets/images/mini_loan_app_logo.png',
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
                          labelText: 'Your Name',
                          controller: _nameController,
                          validator: (value) {
                            if (value == null || value.length < 3) {
                              return 'Must be more than 3 characters';
                            }
                            return null;
                          },
                        ),
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
                                await authViewModel.register(
                                  _emailController.text,
                                  _passwordController.text,
                                );
                                Navigator.pushReplacementNamed(
                                    context, LoginScreen.routeName);
                              } catch (error) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(
                                  SnackBar(
                                      content:
                                      Text('Register failed: $error')),
                                );
                              }
                            }
                          },
                          icon: const Icon(Icons.arrow_forward_outlined),
                          label: const Text('Register'),
                        ),
                        const SizedBox(height: 20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account? ',
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
                                    context, LoginScreen.routeName);
                              },
                              child: Text(
                                'Login here',
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
