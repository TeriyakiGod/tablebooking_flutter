import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tablebooking_flutter/providers/restaurant_provider.dart';
import 'package:tablebooking_flutter/models/restaurant.dart';
import 'package:tablebooking_flutter/search/list/restaurant_info.dart';
import 'package:tablebooking_flutter/restaurant/book/book_view.dart';

import '../providers/auth_provider.dart';

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
  RestaurantViewState createState() => RestaurantViewState();
}

class RestaurantViewState extends State<RestaurantView> {
  late Future<Restaurant> _restaurantFuture;

  @override
  void initState() {
    super.initState();
    _restaurantFuture = widget.restaurant != null
        ? Future.value(widget.restaurant)
        : _fetchRestaurant();
  }

  Future<Restaurant> _fetchRestaurant() async {
    final restaurantProvider =
        Provider.of<RestaurantProvider>(context, listen: false);
    return await restaurantProvider.fetchRestaurantById(widget.restaurantId!);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Restaurant>(
      future: _restaurantFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    } else {
                      GoRouter.of(context).go('/search');
                    }
                  },
                ),
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
                            label: Text("Show on map"),
                            avatar: Icon(Icons.map)),
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
              floatingActionButton: Consumer<AuthProvider>(
                  builder: (context, authProvider, child) {
                if (authProvider.isLoggedIn) {
                  return FloatingActionButton.extended(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              BookView(restaurant: snapshot.data!),
                        ),
                      );
                    },
                    label: const Text("Book a table"),
                    icon: const Icon(Icons.table_restaurant),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              }));
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  } else {
                    GoRouter.of(context).go('/search');
                  }
                },
              ),
              title: const Text("Restaurant"),
            ),
            body: Center(
              child: Text("Error: ${snapshot.error}"),
            ),
          );
        }
        // By default, show a loading spinner.
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
