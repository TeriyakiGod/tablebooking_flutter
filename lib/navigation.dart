import 'package:flutter/material.dart';
import 'package:tablebooking_flutter/search/search.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.search),
            icon: Icon(Icons.home_outlined),
            label: 'Search',
          ),
          NavigationDestination(
            icon: Badge(child: Icon(Icons.calendar_month)),
            label: 'Bookings',
          ),
          NavigationDestination(
            icon: Badge(
              label: Text('2'),
              child: Icon(Icons.person),
            ),
            label: 'Account',
          ),
        ],
      ),
      body: <Widget>[
        /// Home page
        const Search(),

        /// Notifications page
        const Center(child: Text('Bookings')),

        /// Messages page
        const Center(child: Text('Account')),
      ][currentPageIndex],
    );
  }
}
