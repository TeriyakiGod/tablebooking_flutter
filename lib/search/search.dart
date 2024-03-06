import 'package:flutter/material.dart';
import 'package:tablebooking_flutter/models/search_options.dart';
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
  SearchOptions searchOptions = SearchOptions.defaultOptions();

  @override
  void initState() {
    super.initState();
    restaurants = fetchRestaurant();
  }

  Future<List<Restaurant>> fetchRestaurant({String query = ''}) async {
    // TODO: Replace with actual API call, integrate with searchOptions
    // final response = await http.get(
    //     Uri.parse('http://mybackend.com/restaurants'));

    // if (response.statusCode == 200) {
    //   // If the server returns a 200 OK response, then parse the JSON.
    //   return Restaurant.fromJson(jsonDecode(response.body));
    // } else {
    //   // If the server did not return a 200 OK response, then throw an exception.
    //   throw Exception('Failed to load restaurant');
    // }
    await Future.delayed(const Duration(seconds: 1));
    return Restaurant.example();
  }

  void onSearchSubmitted(String value) {
    print('Search for: $value');
    setState(() {
      restaurants = fetchRestaurant(query: value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: SearchBar(
              constraints: const BoxConstraints(
                minHeight: 50,
                maxHeight: 50,
              ),
              leading: const Icon(Icons.search),
              trailing: [
                IconButton(
                  icon: const Icon(Icons.tune),
                  onPressed: () async {
                    final result = await showDialog(
                      context: context,
                      builder: (context) => Dialog.fullscreen(
                        child: Tune(searchOptions: searchOptions),
                      ),
                    );
                    setState(() {
                      searchOptions = result;
                    });
                  },
                )
              ],
              hintText: 'Search for restaurants',
              onSubmitted: onSearchSubmitted,
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
            physics: const NeverScrollableScrollPhysics(),
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
