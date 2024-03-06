import 'package:flutter/material.dart';
import 'package:tablebooking_flutter/models/search_options.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
import 'package:tablebooking_flutter/models/restaurant.dart';
import 'package:tablebooking_flutter/search/list/rating.dart';
import 'package:share_plus/share_plus.dart';

class RestaurantView extends StatefulWidget {
  final String? restaurantId;
  const RestaurantView({super.key, required this.restaurantId});

  @override
  _RestaurantViewState createState() => _RestaurantViewState();
}

class _RestaurantViewState extends State<RestaurantView> {
  late Future<Restaurant> restaurant;

  @override
  void initState() {
    super.initState();
    restaurant = fetchRestaurant();
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
                Container(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 10, bottom: 10),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            snapshot.data!.name,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Rating(
                                    rating: snapshot.data!.rating,
                                  ),
                                  Text(
                                    "${snapshot.data!.type} · ${snapshot.data!.price.displayName}",
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.grey),
                                  ),
                                  Text(
                                    '${snapshot.data!.openTime.hour}:00 - ${snapshot.data!.closeTime.hour}:00',
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.favorite),
                                    onPressed: () => print("Favorite"),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        Share.share(
                                            "Check out this restaurant! https://www.tablebooking.com/#/restaurant/${snapshot.data!.id}");
                                      },
                                      icon: const Icon(
                                        Icons.share,
                                      ))
                                ],
                              )
                            ],
                          ),
                        ])),
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
                //const Divider(),
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
