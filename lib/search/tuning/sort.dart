import 'package:flutter/material.dart';
import 'package:tablebooking_flutter/models/sorting_method.dart';

class Sort extends StatefulWidget {
  const Sort({super.key});

  @override
  State<Sort> createState() => _SortState();
}

class _SortState extends State<Sort> {
  SortingMethod sortingMethod = SortingMethod.trending;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<SortingMethod>(
      segments: const <ButtonSegment<SortingMethod>>[
        ButtonSegment<SortingMethod>(
            value: SortingMethod.trending,
            label: Text('Trending'),
            icon: Icon(Icons.local_fire_department)),
        ButtonSegment<SortingMethod>(
            value: SortingMethod.rating,
            label: Text('Popular'),
            icon: Icon(Icons.star)),
        ButtonSegment<SortingMethod>(
            value: SortingMethod.distance,
            label: Text('Nearby'),
            icon: Icon(Icons.location_on)),
      ],
      selected: <SortingMethod>{sortingMethod},
      onSelectionChanged: (Set<SortingMethod> newSelection) {
        setState(() {
          sortingMethod = newSelection.first;
        });
      },
    );
  }
}
