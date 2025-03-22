import 'package:flutter/material.dart';
import 'package:tablebooking_flutter/models/booking.dart';
import 'package:tablebooking_flutter/models/restaurant.dart';
import 'package:tablebooking_flutter/bookings/manage/manage_booking_view.dart';
import '../restaurant/restaurant_view.dart';

class BookingInfo extends StatelessWidget {
  final Booking booking;
  final Restaurant? restaurant;

  const BookingInfo({super.key, required this.booking, this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (restaurant != null)
            Text(
              restaurant!.name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            )
          else
            const Text(
              "Restaurant details not available",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          const SizedBox(height: 10),
          Wrap(
            direction: Axis.horizontal,
            spacing: 5,
            runSpacing: -5,
            children: [
              Chip(
                avatar: const Icon(Icons.calendar_today),
                label: Text(booking.date.toString().substring(0, 10)),
              ),
              Chip(
                avatar: const Icon(Icons.access_time),
                label: Text(booking.date.toString().substring(11, 16)),
              ),
              ActionChip(
                elevation: 1,
                onPressed: () {
                  if (restaurant != null) {
                    // Navigate to the restaurant details page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RestaurantView(
                          restaurant: restaurant!,
                        ),
                      ),
                    );
                  }
                },
                label: const Text("Restaurant page"),
                avatar: const Icon(Icons.restaurant),
              ),
              ActionChip(
                elevation: 2,
                label: const Text("Manage"),
                avatar: const Icon(Icons.edit),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ManageBookingView(
                        booking: booking,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
