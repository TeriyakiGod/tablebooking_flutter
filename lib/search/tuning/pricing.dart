import 'package:flutter/material.dart';
import 'package:tablebooking_flutter/models/price.dart';

class Pricing extends StatefulWidget {
  const Pricing({super.key});

  @override
  State<Pricing> createState() => _PricingState();
}

class _PricingState extends State<Pricing> {
  Set<Price> selection = <Price>{Price.low, Price.medium, Price.high};

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<Price>(
      segments: const <ButtonSegment<Price>>[
        ButtonSegment<Price>(value: Price.low, label: Text('\$')),
        ButtonSegment<Price>(value: Price.medium, label: Text('\$\$')),
        ButtonSegment<Price>(value: Price.high, label: Text('\$\$\$')),
      ],
      selected: selection,
      onSelectionChanged: (Set<Price> newSelection) {
        setState(() {
          selection = newSelection;
        });
      },
      multiSelectionEnabled: true,
    );
  }
}
