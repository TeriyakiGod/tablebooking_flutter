import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tablebooking_flutter/providers/restaurant_provider.dart';
import 'package:tablebooking_flutter/restaurant/restaurant_card.dart';
import 'package:tablebooking_flutter/models/restaurant.dart';
import 'package:tablebooking_flutter/restaurant/restaurant_view.dart';

class RestaurantList extends StatelessWidget {
  const RestaurantList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantProvider>(
      builder: (context, restaurantProvider, child) {
        // Show a loading spinner if data is being fetched
        if (restaurantProvider.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        // Show an error message if there's an error
        if (restaurantProvider.error.isNotEmpty) {
          return Center(
            child: Text(
              restaurantProvider.error,
              style: const TextStyle(color: Colors.red, fontSize: 16),
            ),
          );
        }

        // Show a message if no restaurants are found
        if (restaurantProvider.restaurants.isEmpty) {
          return const Center(
            child: Text(
              'No restaurants found.',
              style: TextStyle(fontSize: 16),
            ),
          );
        }

        // Display the list of restaurants
        return ListView.builder(
          itemCount: restaurantProvider.restaurants.length,
          itemBuilder: (context, index) {
            Restaurant restaurant = restaurantProvider.restaurants[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        RestaurantView(restaurant: restaurant),
                  ),
                );
              },
              child: RestaurantCard(restaurant: restaurant),
            );
          },
        );
      },
    );
  }
}