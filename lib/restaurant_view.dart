import 'package:flutter/material.dart';
import 'package:tablebooking_flutter/models/restaurant.dart';
import 'package:tablebooking_flutter/models/price.dart';

class RestaurantView extends StatelessWidget {
  const RestaurantView({super.key});

  @override
  Widget build(BuildContext context) {
    final Restaurant restaurant = Restaurant(
      name: 'Restaurant Name',
      type: 'Restaurant Type',
      description: 'Restaurant Description',
      location: 'Restaurant Location',
      phone: 'Restaurant Phone',
      primaryImageURL: 'https://picsum.photos/200/300',
      secondaryImageURL: 'https://picsum.photos/200/300',
      rating: 4.5,
      price: Price.medium,
      openTime: DateTime.utc(2021, 1, 1, 8, 0, 0),
      closeTime: DateTime.utc(2021, 1, 1, 8, 0, 0),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(restaurant.name),
      ),
      body: Column(
        children: <Widget>[
          Image.network(restaurant.primaryImageURL),
        ],
      ),
    );
  }
}
