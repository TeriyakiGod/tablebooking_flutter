import 'package:flutter/material.dart';

class NumberPicker extends StatefulWidget {
  final int limit;

  const NumberPicker({super.key, required this.limit});

  @override
  _NumberPickerState createState() => _NumberPickerState();
}

class _NumberPickerState extends State<NumberPicker> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: counter > 0 ? () => setState(() => counter--) : null,
        ),
        Text('$counter'),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed:
              counter < widget.limit ? () => setState(() => counter++) : null,
        ),
      ],
    );
  }
}
