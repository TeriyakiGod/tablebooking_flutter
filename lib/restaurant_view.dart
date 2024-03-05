import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tablebooking_flutter/models/restaurant.dart';
import 'package:tablebooking_flutter/search/list/restaurant_card.dart';

class RestaurantView extends StatefulWidget {
  final String? restaurantId;
  RestaurantView({Key? key, required this.restaurantId}) : super(key: key);

  @override
  _RestaurantViewState createState() => _RestaurantViewState();
}

class _RestaurantViewState extends State<RestaurantView> {
  late Future<Restaurant> futureRestaurant;

  @override
  void initState() {
    super.initState();
    futureRestaurant = fetchRestaurant();
  }

  Future<Restaurant> fetchRestaurant() async {
    // final response = await http.get(
    //     Uri.parse('http://mybackend.com/restaurants/${widget.restaurantId}'));

    // if (response.statusCode == 200) {
    //   // If the server returns a 200 OK response, then parse the JSON.
    //   return Restaurant.fromJson(jsonDecode(response.body));
    // } else {
    //   // If the server did not return a 200 OK response, then throw an exception.
    //   throw Exception('Failed to load restaurant');
    // }
    return Restaurant.example();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Restaurant>(
      future: futureRestaurant,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Restaurant"),
            ),
            body: Container(
              margin: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
              child: RestaurantCard(
                restaurant: snapshot.data!,
                fullscreen: true,
              ),
            ),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () => print("book"),
              label: const Text("Book a table"),
              icon: const Icon(Icons.table_restaurant),
            ),
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        // By default, show a loading spinner.
        return const CircularProgressIndicator();
      },
    );
  }
}
