import 'package:flutter/material.dart';
import 'package:tablebooking_flutter/search/list/restaurant_card.dart';
import 'package:tablebooking_flutter/models/restaurant.dart';
import 'package:tablebooking_flutter/restaurant/restaurant_view.dart';

class RestaurantList extends StatelessWidget {
  final List<Restaurant> restaurants;

  const RestaurantList({super.key, required this.restaurants});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: restaurants.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          child: RestaurantCard(restaurant: restaurants[index]),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    RestaurantView(restaurant: restaurants[index]),
              ),
            );
          },
        );
      },
    );
  }
}
