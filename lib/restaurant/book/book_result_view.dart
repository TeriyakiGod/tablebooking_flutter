import 'package:flutter/material.dart';
import 'package:tablebooking_flutter/models/booking_request.dart';
import 'package:tablebooking_flutter/models/booking.dart';

class BookResultView extends StatefulWidget {
  final BookingRequest bookingRequest;

  const BookResultView({super.key, required this.bookingRequest});

  @override
  BookResultViewState createState() => BookResultViewState();
}

class BookResultViewState extends State<BookResultView> {
  late Future<Booking> bookingResponse;

  @override
  void initState() {
    super.initState();
    bookingResponse = sendBookingRequest(widget.bookingRequest);
  }

  Future<Booking> sendBookingRequest(BookingRequest bookingRequest) async {
    // final response = await http.post(
    //   Uri.parse('http://mybackend.com/bookings'),
    //   headers: <String, String>{
    //     'Content-Type': 'application/json; charset=UTF-8',
    //   },
    //   body: jsonEncode(bookingRequest.toJson()),
    // );

    // if (response.statusCode == 200) {
    //   return BookingResponse.fromJson(jsonDecode(response.body));
    // } else {
    //   throw Exception('Failed to book a table.');
    // }
    await Future.delayed(const Duration(seconds: 2));
    return Booking.example()[1];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Booking>(
      future: bookingResponse,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Column(
            children: [
              Text('Error: ${snapshot.error}'),
              ElevatedButton(
                onPressed: () {
                  // Navigate to BookingView
                },
                child: const Text('Try Again'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Navigate to BookingsView
                },
                child: const Text('View Bookings'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Navigate to SearchView
                },
                child: const Text('Search'),
              ),
            ],
          );
        } else {
          return Column(
            children: [
              Text("Booking successful!",
                  style: Theme.of(context).textTheme.titleLarge),
              Card(
                margin: const EdgeInsets.all(10.0),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Booking ID: ${snapshot.data!.id}',
                          style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 10.0),
                      Text(
                          'Date: ${snapshot.data!.bookingTime.toString().substring(0, 10)}',
                          style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 10.0),
                      Text(
                          'Time: ${snapshot.data!.bookingTime.toString().substring(11, 16)}',
                          style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 10.0),
                      Text(
                          'Confirmation: ${snapshot.data!.isConfirmed ? 'Confirmed' : 'Pending'}',
                          style: Theme.of(context).textTheme.titleMedium),
                    ],
                  ),
                ),
              ),
              FilledButton(
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: const Text('Done'),
              ),
              const SizedBox(height: 10),
            ],
          );
        }
      },
    );
  }
}
