import 'package:flutter/material.dart';
import 'package:tablebooking_flutter/models/search_options.dart';

class Pricing extends StatelessWidget {
  final Function(Set<Price>) updateOptions;
  final Set<Price> initialPriceSelection;

  const Pricing(
      {super.key,
      required this.updateOptions,
      required this.initialPriceSelection});

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<Price>(
      segments: const <ButtonSegment<Price>>[
        ButtonSegment<Price>(value: Price.low, label: Text('\$')),
        ButtonSegment<Price>(value: Price.medium, label: Text('\$\$')),
        ButtonSegment<Price>(value: Price.high, label: Text('\$\$\$')),
      ],
      selected: initialPriceSelection,
      onSelectionChanged: (Set<Price> newSelection) {
        updateOptions.call(newSelection);
      },
      multiSelectionEnabled: true,
    );
  }
}
