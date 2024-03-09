import 'package:flutter/material.dart';

class NumberPicker extends StatelessWidget {
  final int limit;
  final int value;
  final ValueChanged<int> onChanged;

  const NumberPicker(
      {super.key,
      required this.limit,
      required this.value,
      required this.onChanged});

  static const min = 1;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: value > min ? () => onChanged(value - 1) : null,
        ),
        Text('$value'),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: value < limit ? () => onChanged(value + 1) : null,
        ),
      ],
    );
  }
}
