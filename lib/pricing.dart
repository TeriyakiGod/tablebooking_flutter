import 'package:flutter/material.dart';

enum PriceRange { $, $$, $$$ }

class Pricing extends StatefulWidget {
  const Pricing({super.key});

  @override
  State<Pricing> createState() => _PricingState();
}

class _PricingState extends State<Pricing> {
  Set<PriceRange> selection = <PriceRange>{
    PriceRange.$,
    PriceRange.$$,
    PriceRange.$$$
  };

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<PriceRange>(
      segments: const <ButtonSegment<PriceRange>>[
        ButtonSegment<PriceRange>(value: PriceRange.$, label: Text('\$')),
        ButtonSegment<PriceRange>(value: PriceRange.$$, label: Text('\$\$')),
        ButtonSegment<PriceRange>(value: PriceRange.$$$, label: Text('\$\$\$')),
      ],
      selected: selection,
      onSelectionChanged: (Set<PriceRange> newSelection) {
        setState(() {
          selection = newSelection;
        });
      },
      multiSelectionEnabled: true,
    );
  }
}
