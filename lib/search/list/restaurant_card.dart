import 'package:flutter/material.dart';
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
        children: <Widget>[
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
          Container(
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 10, bottom: 10),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      restaurant.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Rating(
                      rating: restaurant.rating,
                    ),
                  ],
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            restaurant.type,
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
                        children: [
                          IconButton(
                              icon: const Icon(Icons.favorite),
                              onPressed: () => print("Favorite")),
                          IconButton(
                              onPressed: () {
                                Share.share("https://google.com");
                              },
                              icon: const Icon(
                                Icons.share,
                              ))
                        ],
                      )
                    ])
              ])),
        ],
      ),
    );
  }
}
