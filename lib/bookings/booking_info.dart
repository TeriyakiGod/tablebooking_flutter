import 'package:flutter/material.dart';
import 'package:tablebooking_flutter/models/booking.dart';
import 'package:tablebooking_flutter/restaurant/restaurant_view.dart';

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
            Text(
              booking.restaurantName,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Wrap(
              spacing: 8.0,
              children: [
                Chip(
                    avatar: const Icon(Icons.calendar_today),
                    label:
                        Text(booking.bookingTime.toString().substring(0, 10))),
                Chip(
                    avatar: const Icon(Icons.access_time),
                    label:
                        Text(booking.bookingTime.toString().substring(11, 16))),
                Chip(
                    avatar: (booking.isConfirmed
                        ? const Icon(Icons.check)
                        : const Icon(Icons.pending_actions)),
                    label: Text(booking.isConfirmed ? "Confirmed" : "Pending")),
                ActionChip(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RestaurantView(
                              restaurantId: booking.restaurantId),
                        ),
                      );
                    },
                    label: const Text("Restaurant details"),
                    avatar: const Icon(Icons.restaurant)),
                const ActionChip(
                    label: Text("Manage booking"), avatar: Icon(Icons.edit)),
              ],
            ),
          ],
        ));
  }
}
