import 'package:flutter/material.dart';
import 'package:tablebooking_flutter/search/list/restaurant_list.dart';
import 'package:tablebooking_flutter/search/map/restaurant_map.dart';
import 'package:tablebooking_flutter/search/tuning/tune.dart';
import 'package:tablebooking_flutter/models/restaurant.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<Restaurant> restaurants = Restaurant.exampleList();

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
                        return const Dialog.fullscreen(child: Tune());
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
              const RestaurantMap(),
            ],
          ),
        ));
  }
}
