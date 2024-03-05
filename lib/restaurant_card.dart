import 'package:flutter/material.dart';
import 'package:tablebooking_flutter/rating.dart';

class RestaurantCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final int rating;
  final String openingHours;
  final String closingHours;
  final String type;
  final String description;

  const RestaurantCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.rating,
    required this.openingHours,
    required this.closingHours,
    required this.type,
    required this.description,
  });

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
              imageUrl,
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
                      title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Rating(
                      rating: rating,
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
                            type,
                            style: const TextStyle(
                                fontSize: 16, color: Colors.grey),
                          ),
                          Text(
                            '$openingHours - $closingHours ',
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
