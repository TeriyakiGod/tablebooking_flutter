import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tablebooking_flutter/models/booking_request.dart';
import 'package:tablebooking_flutter/models/booking.dart';
import 'package:tablebooking_flutter/providers/booking_provider.dart';

class BookResultView extends StatefulWidget {
  final BookingRequest bookingRequest;
  final String restaurantId;

  const BookResultView({
    super.key,
    required this.bookingRequest,
    required this.restaurantId,
  });

  @override
  BookResultViewState createState() => BookResultViewState();
}

class BookResultViewState extends State<BookResultView> {
  late Future<Booking> bookingResponse;

  @override
  void initState() {
    super.initState();
    bookingResponse = _sendBookingRequest();
  }

  Future<Booking> _sendBookingRequest() async {
    final bookingProvider = Provider.of<BookingProvider>(context, listen: false);
    return bookingProvider.createBooking(
      widget.bookingRequest,
      widget.restaurantId,
      context,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bookingProvider = Provider.of<BookingProvider>(context);

    return FutureBuilder<Booking>(
      future: bookingResponse,
      builder: (context, snapshot) {
        if (bookingProvider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError || bookingProvider.error != null) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Error: ${snapshot.error ?? bookingProvider.error}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    bookingResponse = _sendBookingRequest();
                  });
                },
                child: const Text('Try Again'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  // Navigate to BookingsView
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: const Text('View Bookings'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  // Navigate to SearchView
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: const Text('Search'),
              ),
            ],
          );
        } else if (snapshot.hasData) {
          final booking = snapshot.data!;
          return Column(
            children: [
              Text(
                "Booking successful!",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 20),
              Card(
                margin: const EdgeInsets.all(10.0),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Booking ID: ${booking.id}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        'Date: ${booking.date.toString().substring(0, 10)}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        'Time: ${booking.date.toString().substring(11, 16)}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        'Confirmation: Not implemented',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              FilledButton(
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: const Text('Done'),
              ),
            ],
          );
        } else {
          return const Center(child: Text('Something went wrong.'));
        }
      },
    );
  }
}