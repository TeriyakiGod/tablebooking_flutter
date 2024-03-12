import 'package:flutter/material.dart';
import 'package:tablebooking_flutter/models/booking.dart';
import 'package:tablebooking_flutter/bookings/booking_info.dart';

class BookingCard extends StatelessWidget {
  final Booking booking;

  const BookingCard({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
            child: Image.network(
              booking.restaurantImage,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 200,
            ),
          ),
          BookingInfo(booking: booking)
        ],
      ),
    );
  }
}
