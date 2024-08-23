import 'package:flutter/material.dart';
import 'package:todo2_app/app_colors.dart';
import 'package:todo2_app/firebase_functions.dart';
import 'package:todo2_app/views/auth/login_view.dart';

class RegisterView extends StatelessWidget {
  RegisterView({super.key});
  static const String id = 'RegisterView';
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final userNameController = TextEditingController();
  final ageController = TextEditingController();
  final phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          'Sign Up',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Your User Name';
                    }
                    return null;
                  },
                  controller: userNameController,
                  decoration: const InputDecoration(
                    labelText: 'User Name',
                  ),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Your Age';
                    }
                    if (int.parse(value) < 20) {
                      return 'Sorry at least 20';
                    }
                    return null;
                  },
                  controller: ageController,
                  decoration: const InputDecoration(
                    labelText: 'Age',
                  ),
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Your Phone';
                    }
                    return null;
                  },
                  controller: phoneController,
                  decoration: const InputDecoration(
                    labelText: 'Phone',
                  ),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Your Email';
                    }
                    final bool emailValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[gmail]+\.[com]+")
                        .hasMatch(emailController.text);
                    if (!emailValid) {
                      return 'Please Enter Valid Email';
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
                    final bool passwordValid = RegExp(
                            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                        .hasMatch(passwordController.text);

                    if (!passwordValid) {
                      return 'Please Enter Strong Password';
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
                      FirebaseFunctions.createAccount(
                        userName: userNameController.text,
                        phone: phoneController.text,
                        age: int.parse(ageController.text),
                        email: emailController.text,
                        password: passwordController.text,
                        onSuccess: () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            LoginView.id,
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
                  child: const Text('Sign Up'),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Text.rich(
            textAlign: TextAlign.center,
            TextSpan(
              children: [
                TextSpan(
                  text: 'You have an account? ',
                ),
                TextSpan(
                  text: 'Login',
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
