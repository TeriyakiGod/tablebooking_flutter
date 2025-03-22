import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tablebooking_flutter/providers/restaurant_provider.dart';
import 'package:tablebooking_flutter/models/restaurant.dart';
import 'package:tablebooking_flutter/restaurant/book/book_view.dart';

import '../providers/auth_provider.dart';
import 'restaurant_header.dart'; // Import the new header widget
import 'restaurant_comments.dart'; // Import the new comments widget

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

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
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
    );
  }

  Widget _buildScrollableSection(String description) {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                description,
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
            ),
            const Divider(),
            const RestaurantComments(), // Use the new comments widget
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingActionButton(
      BuildContext context, Restaurant restaurant) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        if (authProvider.isLoggedIn) {
          return FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookView(restaurant: restaurant),
                ),
              );
            },
            label: const Text("Book a table"),
            icon: const Icon(Icons.table_restaurant),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Restaurant>(
      future: _restaurantFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final restaurant = snapshot.data!;
          return Scaffold(
            appBar: _buildAppBar(context),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                RestaurantHeader(
                  restaurant: restaurant,
                ),
                _buildScrollableSection(restaurant.description),
              ],
            ),
            floatingActionButton:
                _buildFloatingActionButton(context, restaurant),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: _buildAppBar(context),
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