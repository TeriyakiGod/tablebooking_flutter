import 'package:flutter/material.dart';
import 'package:tablebooking_flutter/restaurant_card.dart';

class RestaurantList extends StatelessWidget {
  final List<String> restaurants;

  RestaurantList({required this.restaurants});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
      child: ListView.builder(
        itemCount: restaurants.length,
        itemBuilder: (context, index) {
          return RestaurantCard(
            imageUrl: 'https://picsum.photos/seed/${index + 1}/200',
            title: restaurants[index],
            rating: 4,
            openingHours: '10:00',
            closingHours: '22:00',
            type: 'Fast Food',
            description: 'This is a description',
          );
        },
      ),
    );
  }
}
