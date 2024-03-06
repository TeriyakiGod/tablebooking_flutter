import 'package:flutter/material.dart';
import 'package:tablebooking_flutter/models/search_options.dart';

class Sort extends StatelessWidget {
  final Function(SortingMethod) updateOptions;
  final SortingMethod initialSortingMethod;

  const Sort(
      {super.key,
      required this.updateOptions,
      required this.initialSortingMethod});

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
            label: Text('Rating'),
            icon: Icon(Icons.star)),
        ButtonSegment<SortingMethod>(
            value: SortingMethod.distance,
            label: Text('Nearby'),
            icon: Icon(Icons.location_on)),
      ],
      selected: <SortingMethod>{initialSortingMethod},
      onSelectionChanged: (selected) {
        if (selected.isNotEmpty) {
          updateOptions(selected.single);
        }
      },
    );
  }
}
