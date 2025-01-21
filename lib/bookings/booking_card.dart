import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tablebooking_flutter/models/booking.dart';
import 'package:tablebooking_flutter/providers/restaurant_provider.dart';
import 'package:tablebooking_flutter/bookings/booking_info.dart';

import '../models/restaurant.dart';

class BookingCard extends StatefulWidget {
  final Booking booking;

  const BookingCard({super.key, required this.booking});

  @override
  State<BookingCard> createState() => _BookingCardState();
}

class _BookingCardState extends State<BookingCard> {
  Restaurant? _restaurant;
  bool _isLoading = true;
  String _error = '';

  @override
  void initState() {
    super.initState();
    _fetchRestaurant();
  }

  Future<void> _fetchRestaurant() async {
    final restaurantProvider =
        Provider.of<RestaurantProvider>(context, listen: false);
    try {
      final restaurant = await restaurantProvider
          .fetchRestaurantById(widget.booking.restaurantId);
      if (mounted) {
        setState(() {
          _restaurant = restaurant;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = 'Failed to load restaurant details';
          _isLoading = false;
        });
      }
      debugPrint('Error fetching restaurant: $e');
    }
  }

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
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _error.isNotEmpty
                    ? Container(
                        width: double.infinity,
                        height: 200,
                        color: Colors.grey[300],
                        child: Center(
                          child: Text(
                            _error,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      )
                    : _restaurant != null &&
                            _restaurant!.primaryImageURL.isNotEmpty
                        ? Image.network(
                            _restaurant!.primaryImageURL,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 200,
                          )
                        : Image.network(
                            "https://placehold.co/300x200/jpg?text=No%20Image%20Available",
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 200,
                          ),
          ),
          BookingInfo(booking: widget.booking, restaurant: _restaurant),
        ],
      ),
    );
  }
}
