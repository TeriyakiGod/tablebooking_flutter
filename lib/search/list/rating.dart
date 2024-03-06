import 'package:flutter/material.dart';

class Rating extends StatelessWidget {
  final double rating;

  const Rating({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
            Text(
              "$rating ",
              style: const TextStyle(fontSize: 16),
            ),
          ] +
          List.generate(5, (index) {
            return Icon(
              size: 16,
              index < rating ? Icons.star : Icons.star_border,
              color: Colors.amber,
            );
          }),
    );
  }
}
