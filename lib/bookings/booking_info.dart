import 'package:flutter/material.dart';
import 'package:tablebooking_flutter/models/booking.dart';

class BookingInfo extends StatelessWidget {
  final Booking booking;

  const BookingInfo({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding:
            const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TODO: Implement
            Text(
              "Not implemented",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              direction: Axis.horizontal,
              spacing: 10,
              runSpacing: 10,
              children: [
                Chip(
                    avatar: const Icon(Icons.access_time),
                    label:
                        Text(booking.date.toString().substring(11, 16))),
                Chip(
                    avatar: const Icon(Icons.calendar_today),
                    label:
                        Text(booking.date.toString().substring(0, 10))),
                Chip(
                    avatar: (true
                        ? const Icon(Icons.check)
                        : const Icon(Icons.pending_actions)),
                        // TODO: Implement
                    label: Text("Not implemented")),
                ActionChip(
                    elevation: 1,
                    onPressed: () {
                      // TODO: Implement
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => RestaurantView(
                      //         restaurantId: booking.),
                      //   ),
                      // );
                    },
                    label: const Text("Restaurant details"),
                    avatar: const Icon(Icons.restaurant)),
                ActionChip(
                  elevation: 2,
                  label: const Text("Manage booking"),
                  avatar: const Icon(Icons.edit),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ));
  }
}
