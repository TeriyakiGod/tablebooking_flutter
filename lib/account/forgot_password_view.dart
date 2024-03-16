import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tablebooking_flutter/providers/auth_provider.dart';

class ForgotPasswordView extends StatelessWidget {
  ForgotPasswordView({super.key});
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Forgot Password'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                    margin: const EdgeInsets.all(10),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          TextField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                              labelText: 'Email',
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 20),
                          FilledButton(
                            child: const Text('Send Password Reset Email'),
                            onPressed: () {
                              final String email = _emailController.text;
                              if (email.isNotEmpty) {
                                Provider.of<AuthProvider>(context,
                                        listen: false)
                                    .sendPasswordResetEmail(email);
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'Password reset email sent. Please check your email.'),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Please enter an email.'),
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    )),
              ],
            )));
  }
}
