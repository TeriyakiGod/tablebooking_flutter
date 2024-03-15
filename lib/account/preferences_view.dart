import 'package:flutter/material.dart';

class PreferencesView extends StatefulWidget {
  const PreferencesView({super.key});

  @override
  _PreferencesViewState createState() => _PreferencesViewState();
}

class _PreferencesViewState extends State<PreferencesView> {
  ThemeMode _themeMode = ThemeMode.system;

  void _toggleTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }

  //TODO: Add theme switching
  @override
  Widget build(BuildContext context) {
    bool darkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preferences'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            SwitchListTile(
              title: const Text('Dark Mode'),
              value: darkMode,
              onChanged: (isOn) {
                isOn
                    ? _toggleTheme(ThemeMode.dark)
                    : _toggleTheme(ThemeMode.light);
              },
            ),
            // Add more preferences here
          ],
        ),
      ),
    );
  }
}
