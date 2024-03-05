import 'package:flutter/material.dart';
import 'package:tablebooking_flutter/search/tuning/sort.dart';
import 'package:tablebooking_flutter/search/tuning/pricing.dart';
import 'package:tablebooking_flutter/search/tuning/distance.dart';

class Tune extends StatelessWidget {
  const Tune({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tune'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: const Column(
        children: <Widget>[
          ListTile(
            title: Text(
              'Sort by',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Sort(),
          ListTile(
            title: Text(
              "Pricing",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Pricing(),
          ListTile(
            title: Text(
              "Distance",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          DistanceSlider(),
        ],
      ),
    );
  }
}
