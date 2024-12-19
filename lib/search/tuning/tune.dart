import 'package:flutter/material.dart';
import 'package:tablebooking_flutter/models/search_options.dart';
import 'package:tablebooking_flutter/search/tuning/sort.dart';
import 'package:tablebooking_flutter/search/tuning/pricing.dart';
import 'package:tablebooking_flutter/search/tuning/distance.dart';

class Tune extends StatefulWidget {
  final SearchOptions searchOptions;
  const Tune({super.key, required this.searchOptions});

  @override
  TuneState createState() => TuneState();
}

class TuneState extends State<Tune> {
  late SearchOptions searchOptions;
  late SearchOptions initialState;

  @override
  void initState() {
    super.initState();
    searchOptions = widget.searchOptions;
    initialState = searchOptions.copyWith();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, initialState);
          },
        ),
        title: const Text('Tune'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              Navigator.pop(context, searchOptions);
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Card(
              margin: const EdgeInsets.only(bottom: 8, left: 10, right: 10),
              child: Column(
                children: [
                  const ListTile(
                    title: Text(
                      'Sort by',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Sort(
                    onChanged: (value) {
                      setState(() {
                        searchOptions.sortingMethod = value;
                      });
                    },
                    initialSortingMethod: searchOptions.sortingMethod,
                  ),
                  const SizedBox(height: 20),
                ],
              )),
          Card(
            margin: const EdgeInsets.only(bottom: 8, left: 10, right: 10),
            child: Column(
              children: [
                const ListTile(
                  title: Text(
                    "Pricing",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Pricing(
                  onChanged: (value) {
                    setState(() {
                      searchOptions.price = value;
                    });
                  },
                  initialPriceSelection: searchOptions.price,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          Card(
            margin: const EdgeInsets.only(bottom: 8, left: 10, right: 10),
            child: Column(
              children: [
                const ListTile(
                  title: Text(
                    "Distance",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                DistanceSlider(
                  onChanged: (value) {
                    setState(() {
                      searchOptions.distance = value;
                    });
                  },
                  initialSliderValue: searchOptions.distance,
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
