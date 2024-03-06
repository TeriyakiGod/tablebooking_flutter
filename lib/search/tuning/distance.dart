import 'package:flutter/material.dart';

class DistanceSlider extends StatelessWidget {
  final double maxDistance = 10;
  final double initialSliderValue;
  final Function(double) updateOptions;

  const DistanceSlider({
    super.key,
    this.initialSliderValue = 10,
    required this.updateOptions,
  });

  @override
  Widget build(BuildContext context) {
    return Slider(
      value: initialSliderValue,
      max: maxDistance,
      divisions: 10,
      label: (initialSliderValue == maxDistance)
          ? "${initialSliderValue.round()}+ km"
          : "${initialSliderValue.round()} km",
      onChanged: (value) {
        updateOptions.call(value);
      },
    );
  }
}
