import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo2_app/app_colors.dart';
import 'package:todo2_app/firebase_functions.dart';
import 'package:todo2_app/providers/auth_provider.dart';
import 'package:todo2_app/views/auth/register_view.dart';
import 'package:todo2_app/views/home_view.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});
  static const String id = 'LoginView';
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          'Login',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Your Email';
                  }
                  return null;
                },
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Your Password';
                  }
                  return null;
                },
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
              ),
              const SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    FirebaseFunctions.login(
                      email: emailController.text,
                      password: passwordController.text,
                      onSuccess: () {
                        authProvider.initUser();
                        Future.delayed(const Duration(milliseconds: 500));
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          HomeView.id,
                          (route) => false,
                        );
                      },
                      onError: (message) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text(
                                'Error',
                              ),
                              content: Text(message),
                              actions: [
                                ElevatedButton(
                                  onPressed: () {},
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    );
                  }
                },
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, RegisterView.id);
          },
          child: const Text.rich(
            textAlign: TextAlign.center,
            TextSpan(
              children: [
                TextSpan(
                  text: 'You have not an account? ',
                ),
                TextSpan(
                  text: 'SignUp',
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
