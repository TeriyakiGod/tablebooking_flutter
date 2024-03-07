import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
import 'package:tablebooking_flutter/models/restaurant.dart';
import 'package:tablebooking_flutter/search/list/restaurant_info.dart';
import 'package:tablebooking_flutter/booking_view.dart';

class RestaurantView extends StatefulWidget {
  final Restaurant? restaurant;
  final String? restaurantId;

  RestaurantView({super.key, this.restaurant, this.restaurantId}) {
    if (restaurant == null && restaurantId == null) {
      throw ArgumentError(
          'You must provide either a restaurant or a restaurantId');
    }
  }

  @override
  _RestaurantViewState createState() => _RestaurantViewState();
}

class _RestaurantViewState extends State<RestaurantView> {
  late Future<Restaurant> restaurant;

  @override
  void initState() {
    super.initState();
    restaurant = widget.restaurant != null
        ? Future.value(widget.restaurant)
        : fetchRestaurant();
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
    return Restaurant.example()
        .firstWhere((element) => element.id == widget.restaurantId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Restaurant>(
      future: restaurant,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Restaurant"),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.network(
                  snapshot.data!.primaryImageURL,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200,
                ),
                RestaurantInfo(restaurant: snapshot.data!),
                const Divider(),
                const SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Wrap(
                    spacing: 8.0,
                    children: [
                      ActionChip(
                        label: Text("Call restaurant"),
                        avatar: Icon(Icons.phone),
                      ),
                      ActionChip(
                          label: Text("View menu"), avatar: Icon(Icons.menu)),
                      ActionChip(
                          label: Text("Show on map"), avatar: Icon(Icons.map)),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, bottom: 75, top: 10),
                    child: Text(
                      snapshot.data!.description,
                      style: const TextStyle(fontSize: 16),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                )
              ],
            ),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        BookingView(restaurant: snapshot.data!),
                  ),
                );
              },
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
