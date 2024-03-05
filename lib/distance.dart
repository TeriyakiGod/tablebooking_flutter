import 'package:flutter/material.dart';

class DistanceSlider extends StatefulWidget {
  const DistanceSlider({super.key});

  @override
  State<DistanceSlider> createState() => _DistanceSliderState();
}

class _DistanceSliderState extends State<DistanceSlider> {
  final double maxDistance = 10;
  double _currentSliderValue = 10;

  @override
  Widget build(BuildContext context) {
    return Slider(
      value: _currentSliderValue,
      max: maxDistance,
      divisions: 10,
      label: (_currentSliderValue == maxDistance)
          ? "${_currentSliderValue.round()}+ km"
          : "${_currentSliderValue.round()} km",
      onChanged: (double value) {
        setState(() {
          _currentSliderValue = value;
        });
      },
    );
  }
}
