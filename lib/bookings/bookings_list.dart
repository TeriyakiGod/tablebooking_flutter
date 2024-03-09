import 'package:flutter/material.dart';
import 'package:tablebooking_flutter/bookings/booking_card.dart';
import 'package:tablebooking_flutter/models/booking.dart';

class BookingsList extends StatelessWidget {
  final List<Booking> bookings;

  const BookingsList({super.key, required this.bookings});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: bookings.length,
      itemBuilder: (context, index) {
        return BookingCard(booking: bookings[index]);
      },
    );
  }
}
