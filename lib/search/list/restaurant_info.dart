import 'package:flutter/material.dart';
import 'package:tablebooking_flutter/models/restaurant.dart';
import 'package:tablebooking_flutter/search/list/rating.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tablebooking_flutter/models/search_options.dart';

class RestaurantInfo extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantInfo({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              restaurant.name,
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
                      rating: restaurant.rating,
                    ),
                    Text(
                      "${restaurant.type} · ${restaurant.price.displayName}",
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    Text(
                      '${restaurant.openTime.hour}:00 - ${restaurant.closeTime.hour}:00',
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
                      onPressed: () {
                      throw UnimplementedError("Favorite feature not implemented");
                      },
                    ),
                    IconButton(
                        onPressed: () {
                          Share.share(
                              "Check out this restaurant! https://www.tablebooking.com/#/restaurant/${restaurant.hashCode}");
                        },
                        icon: const Icon(
                          Icons.share,
                        ))
                  ],
                )
              ],
            ),
          ],
        ));
  }
}
