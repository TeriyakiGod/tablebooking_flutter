import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tablebooking_flutter/providers/auth_provider.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  SignUpViewState createState() => SignUpViewState();
}

class SignUpViewState extends State<SignUpView> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();

  // Focus nodes for managing input focus
  final FocusNode _userNameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();

  @override
  void dispose() {
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    _userNameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildForm(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('Sign Up'),
    );
  }

  Widget _buildForm() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: AutofillGroup(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildUserNameField(),
              const SizedBox(height: 10),
              _buildEmailField(),
              const SizedBox(height: 10),
              _buildPasswordField(),
              const SizedBox(height: 10),
              _buildConfirmPasswordField(),
              const SizedBox(height: 10),
              _buildRequiredFieldText(),
              const SizedBox(height: 10),
              _buildSignUpButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserNameField() {
    return TextFormField(
      key: const ValueKey('username_field'), // Unique key
      controller: _userNameController,
      focusNode: _userNameFocusNode,
      decoration: const InputDecoration(
        labelText: 'Username *',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your username';
        }
        return null;
      },
      autofillHints: const [AutofillHints.username],
      onTap: () {
        debugPrint('Username field tapped');
      },
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      key: const ValueKey('email_field'), // Unique key
      controller: _emailController,
      focusNode: _emailFocusNode,
      decoration: const InputDecoration(
        labelText: 'Email *',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        }
        return null;
      },
      autofillHints: const [AutofillHints.email],
      onTap: () {
        debugPrint('Email field tapped');
      },
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      key: const ValueKey('password_field'), // Unique key
      controller: _passwordController,
      focusNode: _passwordFocusNode,
      decoration: const InputDecoration(
        labelText: 'Password *',
      ),
      obscureText: true,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password';
        }
        return null;
      },
      autofillHints: const [AutofillHints.newPassword],
      onTap: () {
        debugPrint('Password field tapped');
      },
    );
  }

  Widget _buildConfirmPasswordField() {
    return TextFormField(
      key: const ValueKey('confirm_password_field'), // Unique key
      controller: _confirmPasswordController,
      focusNode: _confirmPasswordFocusNode,
      decoration: const InputDecoration(
        labelText: 'Confirm Password *',
      ),
      obscureText: true,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please confirm your password';
        }
        if (value != _passwordController.text) {
          return 'Passwords do not match';
        }
        return null;
      },
      autofillHints: const [AutofillHints.newPassword],
      onTap: () {
        debugPrint('Confirm password field tapped');
      },
    );
  }

  Widget _buildRequiredFieldText() {
    return const Text(
      '* indicates required field',
    );
  }

  Widget _buildSignUpButton() {
    return Center(
      child: ElevatedButton(
        onPressed: _onSignUpPressed,
        child: const Text('Sign Up'),
      ),
    );
  }

  void _onSignUpPressed() async {
    if (_formKey.currentState!.validate()) {
      final username = _userNameController.text;
      final email = _emailController.text;
      final password = _passwordController.text;

      // Call the API to sign up
      try {
        await Provider.of<AuthProvider>(context, listen: false).register(
          username,
          email,
          password,
        );
      } catch (e) {
        // Handle exceptions and show a SnackBar with the error message
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Registration failed: $e'),
            ),
          );
        }
      }
    }
  }
}
