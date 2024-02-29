import 'package:flutter/material.dart';

class Tune extends StatelessWidget {
  const Tune({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Options'),
      content: Column(
        children: <Widget>[
          const Text('Sort By'),
          const SizedBox(height: 10),
          ToggleButtons(
            isSelected: const [true, false, false],
            children: const <Widget>[
              Padding(
                padding: EdgeInsets.all(10),
                child: Text('Option 1'),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text('Option 2'),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text('Option 3'),
              ),
            ],
            onPressed: (int index) {},
          ),
          const SizedBox(height: 20),
          const Text('Filter'),
          const SizedBox(height: 10),
          ToggleButtons(
            isSelected: const [true, false, false],
            children: const <Widget>[
              Padding(
                padding: EdgeInsets.all(10),
                child: Text('Filter 1'),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text('Filter 2'),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text('Filter 3'),
              ),
            ],
            onPressed: (int index) {},
          ),
          const SizedBox(height: 20),
          Slider(
            value: 0.5,
            onChanged: (double value) {},
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('Apply'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
