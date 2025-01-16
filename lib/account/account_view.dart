import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tablebooking_flutter/providers/auth_provider.dart';
import 'account_info_view.dart';
import 'signin_view.dart';

class AccountView extends StatelessWidget {
  const AccountView({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return FutureBuilder<void>(
      future: authProvider.fetchUserInfo(), // Fetch user info if authenticated
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return authProvider.isAuthenticated && authProvider.account != null
              ? AccountInfoView(account: authProvider.account!) // Pass the Account object
              : const SignInView(); // Switch based on auth status
        }
      },
    );
  }
}