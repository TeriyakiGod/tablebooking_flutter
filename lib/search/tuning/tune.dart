import 'package:flutter/material.dart';
import 'package:tablebooking_flutter/models/search_options.dart';
import 'package:tablebooking_flutter/search/tuning/sort.dart';
import 'package:tablebooking_flutter/search/tuning/pricing.dart';
import 'package:tablebooking_flutter/search/tuning/distance.dart';

class Tune extends StatefulWidget {
  final SearchOptions searchOptions;
  const Tune({super.key, required this.searchOptions});

  @override
  _TuneState createState() => _TuneState();
}

class _TuneState extends State<Tune> {
  late SearchOptions searchOptions;
  late SearchOptions initialState;

  @override
  void initState() {
    super.initState();
    searchOptions = widget.searchOptions;
    initialState = searchOptions;
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
          const ListTile(
            title: Text(
              'Sort by',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Sort(
            updateOptions: (value) {
              setState(() {
                searchOptions = searchOptions.copyWith(sortingMethod: value);
              });
            },
            initialSortingMethod: searchOptions.sortingMethod,
          ),
          const ListTile(
            title: Text(
              "Pricing",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Pricing(
            updateOptions: (value) {
              setState(() {
                searchOptions = searchOptions.copyWith(price: value);
              });
            },
            initialPriceSelection: searchOptions.price,
          ),
          const ListTile(
            title: Text(
              "Distance",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          DistanceSlider(
            updateOptions: (value) {
              setState(() {
                searchOptions = searchOptions.copyWith(distance: value);
              });
            },
            initialSliderValue: searchOptions.distance,
          ),
        ],
      ),
    );
  }
}
