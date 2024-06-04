import 'package:flutter/material.dart';
import 'package:tablebooking_flutter/models/search_options.dart';
import 'package:tablebooking_flutter/search/list/restaurant_list.dart';
import 'package:tablebooking_flutter/search/tuning/tune.dart';
import 'package:tablebooking_flutter/models/restaurant.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  Future<List<Restaurant>> restaurants = fetchRestaurant();
  SearchOptions searchOptions = SearchOptions.defaultOptions();

  // @override
  // void initState() {
  //   super.initState();
  //   restaurants = fetchRestaurant();
  // }

  static Future<List<Restaurant>> fetchRestaurant({String query = ''}) async {
    var url = Uri.parse(
        'http://server.kacperochnik.eu:7012/Restaurant/GetAllRestaurants?restuarantName=$query');
    final response =
        await http.get(url, headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, then parse the JSON.
      return (json.decode(response.body) as List)
          .map((data) => Restaurant.fromJson(data))
          .toList();
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to load restaurant');
    }
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
                minHeight: 40,
                maxHeight: 40,
              ),
              leading: const Icon(Icons.search),
              trailing: [
                //TODO: Integrate the button within tune widget
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
              FutureBuilder(
                  // pass the list (postsFuture)
                  future: restaurants,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasData) {
                      final finalRestaurants = snapshot.data!;
                      return RestaurantList(restaurants: finalRestaurants);
                    } else {
                      // we did not recieve any data, maybe show error or no data available
                      return const Center(child: Text('No data available'));
                    }
                  }),
              // FutureBuilder<List<Restaurant>>(
              //   future: restaurants,
              //   builder: (context, snapshot) {
              //     if (snapshot.connectionState == ConnectionState.waiting) {
              //       return const Center(child: CircularProgressIndicator());
              //     } else if (snapshot.hasError) {
              //       return Text('Error: ${snapshot.error}');
              //     } else {
              //       return RestaurantMap(restaurants: snapshot.data ?? []);
              //     }
              //   },
              // ),
              // TODO: Replace with RestaurantMap
              const Center(child: Text('Map view coming soon!')),
            ],
          ),
        ));
  }
}
