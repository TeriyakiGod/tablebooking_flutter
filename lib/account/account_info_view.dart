import 'package:flutter/material.dart';
import 'package:tablebooking_flutter/account/help_view.dart';
import 'about_view.dart';
import 'preferences_view.dart';
import 'package:tablebooking_flutter/models/account.dart';
import 'package:provider/provider.dart';
import 'package:tablebooking_flutter/providers/auth_provider.dart';

class AccountInfoView extends StatelessWidget {
  final Account account;
  const AccountInfoView({super.key, required this.account});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('My account'),
        ),
        body: Column(children: [
          Card(
            margin: const EdgeInsets.only(bottom: 8, left: 10, right: 10),
            child: ListTile(
              title: Text(account.name, style: const TextStyle(fontSize: 30)),
              subtitle: Text(account.email),
              trailing: const Icon(Icons.account_circle, size: 50.0),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                const ListTile(
                  title: Text('Favorites'),
                  leading: Icon(Icons.favorite),
                ),
                const ListTile(
                  title: Text('Promotions'),
                  leading: Icon(Icons.local_offer),
                ),
                const ListTile(
                  title: Text('Personal information'),
                  leading: Icon(Icons.person),
                ),
                ListTile(
                    title: const Text('Preferences'),
                    leading: const Icon(Icons.settings),
                    onTap: () {
                      // Navigate to PreferencesView
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PreferencesView()),
                      );
                    }),
                ListTile(
                  title: const Text('Help'),
                  leading: const Icon(Icons.help),
                  onTap: () {
                    // Navigate to HelpView
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HelpView()),
                    );
                  },
                ),
                ListTile(
                  title: const Text('About'),
                  leading: const Icon(Icons.info),
                  onTap: () {
                    // Navigate to AboutView
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AboutView()),
                    );
                  },
                ),
                ListTile(
                    title: const Text('Log out'),
                    leading: const Icon(Icons.exit_to_app),
                    onTap: () {
                      Provider.of<AuthProvider>(context, listen: false)
                          .logOut();
                    }),
              ],
            ),
          ),
        ]));
  }
}
