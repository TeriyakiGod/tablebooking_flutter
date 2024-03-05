import 'package:flutter/material.dart';
import 'package:tablebooking_flutter/search/list/rating.dart';
import 'package:tablebooking_flutter/models/restaurant.dart';

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
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
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
                      const Row(
                        children: [
                          IconButton(
                              icon: Icon(Icons.favorite),
                              onPressed: null,
                              color: Colors.red),
                          IconButton(
                              onPressed: null,
                              icon: Icon(
                                Icons.share,
                              ))
                        ],
                      )
                    ])
              ],
            ),
          )
        ],
      ),
    );
  }
}
