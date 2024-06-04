import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tablebooking_flutter/providers/restaurant_provider.dart';
import 'package:tablebooking_flutter/search/list/restaurant_card.dart';
import 'package:tablebooking_flutter/models/restaurant.dart';
import 'package:tablebooking_flutter/restaurant/restaurant_view.dart';

class RestaurantList extends StatelessWidget {
  const RestaurantList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantProvider>(
      builder: (context, restaurantProvider, child) {
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
