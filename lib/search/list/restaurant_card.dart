import 'package:flutter/material.dart';
import 'package:tablebooking_flutter/models/price.dart';
import 'package:tablebooking_flutter/search/list/rating.dart';
import 'package:tablebooking_flutter/models/restaurant.dart';
import 'package:share_plus/share_plus.dart';

class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantCard({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
                child: Image.network(
                  restaurant.primaryImageURL,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200,
                ),
              ),
            ],
          ),
          Container(
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 10, bottom: 10),
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
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.grey),
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
                              onPressed: () => print("Favorite"),
                            ),
                            IconButton(
                                onPressed: () {
                                  Share.share(
                                      "Check out this restaurant! https://www.tablebooking.com/#/restaurant/${restaurant.id}");
                                },
                                icon: const Icon(
                                  Icons.share,
                                ))
                          ],
                        )
                      ],
                    ),
                  ])),
        ],
      ),
    );
  }
}
