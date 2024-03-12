import 'package:flutter/material.dart';

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
              children: const [
                ListTile(
                  title: Text('Favorites'),
                  leading: Icon(Icons.favorite),
                ),
                ListTile(
                  title: Text('Promotions'),
                  leading: Icon(Icons.local_offer),
                ),
                ListTile(
                  title: Text('Personal information'),
                  leading: Icon(Icons.person),
                ),
                ListTile(
                  title: Text('Preferences'),
                  leading: Icon(Icons.settings),
                ),
                ListTile(
                  title: Text('Help'),
                  leading: Icon(Icons.help),
                ),
                ListTile(
                  title: Text('About'),
                  leading: Icon(Icons.info),
                ),
                ListTile(
                  title: Text('Log out'),
                  leading: Icon(Icons.exit_to_app),
                ),
              ],
            ),
          ),
        ]));
  }
}
