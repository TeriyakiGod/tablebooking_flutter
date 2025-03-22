import 'package:flutter/material.dart';
import 'package:tablebooking_flutter/search/list/rating.dart';

class RestaurantComments extends StatelessWidget {
  const RestaurantComments({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 10.0),
          child: Text(
            'Reviews',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 10),
        ListTile(
          leading: const CircleAvatar(
            child: Text('A'),
          ),
          title: const Text('Alice'),
          subtitle: const Text('Great food and excellent service!'),
          trailing: Rating(rating: 4.5),
        ),
        ListTile(
          leading: const CircleAvatar(
            child: Text('B'),
          ),
          title: const Text('Bob'),
          subtitle: const Text('Loved the ambiance and the food was delicious.'),
          trailing: Rating(rating: 4.0),
        ),
        ListTile(
          leading: const CircleAvatar(
            child: Text('C'),
          ),
          title: const Text('Charlie'),
          subtitle: const Text('A bit pricey, but worth it for the quality.'),
          trailing: Rating(rating: 3.5),
        ),
      ],
    );
  }
}