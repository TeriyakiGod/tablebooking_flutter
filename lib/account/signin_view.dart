import 'package:flutter/material.dart';
import 'signup_view.dart';
import 'package:provider/provider.dart';
import 'package:tablebooking_flutter/providers/auth_provider.dart';
import 'forgot_password_view.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  SignInViewState createState() => SignInViewState();
}

class SignInViewState extends State<SignInView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  void _handleSignIn() async {
    // Remove focus from text fields
    _emailFocusNode.unfocus();
    _passwordFocusNode.unfocus();

    // Validate if fields are empty
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields'),
        ),
      );
      return; // Exit the function if fields are empty
    }

    try {
      // Call the login method from AuthProvider
      await Provider.of<AuthProvider>(context, listen: false).login(
        _emailController.text,
        _passwordController.text,
      );
    } catch (e) {
      // Handle exceptions and show a SnackBar with the error message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login failed: $e'),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    // Dispose of the FocusNodes to avoid memory leaks
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  // Main Body
  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Text(
            'Sign in',
            style: TextStyle(fontSize: 30),
          ),
          _buildLoginCard(),
          const Text('or'),
          const SizedBox(height: 5),
          _buildSignUpButton(),
        ],
      ),
    );
  }

  // Login Card
  Widget _buildLoginCard() {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildEmailField(),
            const SizedBox(height: 10),
            _buildPasswordField(),
            const SizedBox(height: 10),
            _buildLoginButtonRow(),
          ],
        ),
      ),
    );
  }

  // Email Field
  Widget _buildEmailField() {
    return TextField(
      controller: _emailController,
      focusNode: _emailFocusNode, // Assign FocusNode
      decoration: const InputDecoration(
        labelText: 'Username',
      ),
      textInputAction: TextInputAction.next, // Move focus to the next field
      onSubmitted: (_) {
        // When "Next" is pressed, move focus to the password field
        FocusScope.of(context).requestFocus(_passwordFocusNode);
      },
    );
  }

  // Password Field
  Widget _buildPasswordField() {
    return TextField(
      controller: _passwordController,
      focusNode: _passwordFocusNode, // Assign FocusNode
      decoration: const InputDecoration(
        labelText: 'Password',
      ),
      obscureText: true,
      textInputAction:
          TextInputAction.done, // Close the keyboard when "Done" is pressed
      onSubmitted: (_) {
        // When "Done" is pressed, remove focus from the password field
        _passwordFocusNode.unfocus();
      },
    );
  }

  // Login Button Row
  Widget _buildLoginButtonRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildForgotPasswordButton(),
        _buildSignInButton(),
      ],
    );
  }

  // Forgot Password Button
  Widget _buildForgotPasswordButton() {
    return TextButton(
      onPressed: () {
        // Remove focus from text fields when navigating
        _emailFocusNode.unfocus();
        _passwordFocusNode.unfocus();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ForgotPasswordView(),
          ),
        );
      },
      child: const Text(
        'Forgot your password?',
        textAlign: TextAlign.left,
      ),
    );
  }

  // Sign In Button
  Widget _buildSignInButton() {
    return FilledButton(
      onPressed: _handleSignIn,
      child: const Text('Sign in'),
    );
  }

  // Sign Up Button
  Widget _buildSignUpButton() {
    return ElevatedButton(
      onPressed: () {
        // Remove focus from text fields when navigating
        _emailFocusNode.unfocus();
        _passwordFocusNode.unfocus();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SignUpView(),
          ),
        );
      },
      child: const Text('Create an account'),
    );
  }
}
