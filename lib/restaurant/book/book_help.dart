import 'package:flutter/material.dart';

class BookingHelp extends StatelessWidget {
  const BookingHelp({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.help),
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Booking Rules'),
              content: const SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text(
                        '1. Bookings must be made at least 2 hours in advance.'),
                    Text(
                        '2. Bookings can only be made during restaurant working hours.'),
                    Text(
                        '3. Bookings can only be made up to 2 hours before restaurant closing time.'),
                    Text(
                        '4. Bookings can be made for up to 90 days in advance.'),
                    Text(
                        "5. Bookings can be made for up to 10 people. Otherwise contact restaurant.")
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Got it'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
