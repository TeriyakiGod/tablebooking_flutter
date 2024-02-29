import 'package:flutter/material.dart';
import 'package:tablebooking_flutter/restaurant_list.dart';
import 'package:tablebooking_flutter/restaurant_map.dart';
import 'package:tablebooking_flutter/tune.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<String> restaurants = ['Restaurant 1', 'Restaurant 2', 'Restaurant 3'];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Row(
              children: <Widget>[
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: Icon(Icons.search),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.tune),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const Tune();
                      },
                    );
                  },
                ),
              ],
            ),
            bottom: const TabBar(
              tabs: <Widget>[
                Tab(
                  icon: Icon(Icons.list),
                ),
                Tab(
                  icon: Icon(Icons.map),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              RestaurantList(restaurants: restaurants),
              RestaurantMap(),
            ],
          ),
        ));
  }
}
