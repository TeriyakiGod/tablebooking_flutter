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
  late Future<List<Restaurant>> restaurants;

  @override
  void initState() {
    super.initState();
    restaurants = fetchRestaurant();
  }

  Future<List<Restaurant>> fetchRestaurant() async {
    // final response = await http.get(
    //     Uri.parse('http://mybackend.com/restaurants'));

    // if (response.statusCode == 200) {
    //   // If the server returns a 200 OK response, then parse the JSON.
    //   return Restaurant.fromJson(jsonDecode(response.body));
    // } else {
    //   // If the server did not return a 200 OK response, then throw an exception.
    //   throw Exception('Failed to load restaurant');
    // }
    return Restaurant.exampleList();
  }

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
              FutureBuilder<List<Restaurant>>(
                future: restaurants,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return RestaurantList(restaurants: snapshot.data ?? []);
                  }
                },
              ),
              FutureBuilder<List<Restaurant>>(
                future: restaurants,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return RestaurantMap(restaurants: snapshot.data ?? []);
                  }
                },
              ),
            ],
          ),
        ));
  }
}
