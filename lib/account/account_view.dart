import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tablebooking_flutter/providers/auth_provider.dart';
import 'account_info_view.dart';
import 'signin_view.dart';

class AccountView extends StatelessWidget {
  const AccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, authProvider, child) {
      return authProvider.isLoggedIn
          ? AccountInfoView(account: authProvider.account!)
          : const SignInView();
    });
  }
}
