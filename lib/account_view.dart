import 'package:flutter/material.dart';
import 'package:tablebooking_flutter/help_view.dart';
import 'about_view.dart';

class AccountView extends StatelessWidget {
  const AccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('My account'),
        ),
        body: Column(children: [
          const Card(
            margin: EdgeInsets.only(bottom: 8, left: 10, right: 10),
            child: ListTile(
              title: Text("Name Surname", style: TextStyle(fontSize: 30)),
              subtitle: Text("address@email.com"),
              trailing: Icon(Icons.account_circle, size: 50.0),
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
                const ListTile(
                  title: Text('Preferences'),
                  leading: Icon(Icons.settings),
                ),
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
                const ListTile(
                  title: Text('Log out'),
                  leading: Icon(Icons.exit_to_app),
                ),
              ],
            ),
          ),
        ]));
  }
}
