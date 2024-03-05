import 'package:flutter/material.dart';
import 'package:tablebooking_flutter/search/list/rating.dart';
import 'package:tablebooking_flutter/models/restaurant.dart';
import 'package:share_plus/share_plus.dart';

class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;
  final bool fullscreen;

  const RestaurantCard(
      {super.key, required this.restaurant, required this.fullscreen});

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
          if (fullscreen)
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Wrap(
                spacing: 8.0,
                children: [
                  Chip(
                      label: Text("Call restaurant"),
                      avatar: Icon(Icons.phone)),
                  Chip(label: Text("View menu"), avatar: Icon(Icons.menu)),
                  Chip(label: Text("Show on map"), avatar: Icon(Icons.map)),
                ],
              ),
            ),
          if (fullscreen) const Divider(),
          if (fullscreen)
            Expanded(
                child: Container(
              padding: const EdgeInsets.only(bottom: 10),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 50),
                child: Text(
                  restaurant.description,
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.justify,
                ),
              ),
            ))
        ],
      ),
    );
  }
}
