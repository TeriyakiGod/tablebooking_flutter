import 'package:flutter/material.dart';
import 'package:tablebooking_flutter/models/booking_request.dart';
import 'package:tablebooking_flutter/models/booking_response.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BookingResultView extends StatefulWidget {
  final BookingRequest bookingRequest;

  BookingResultView({required this.bookingRequest});

  @override
  _BookingResultViewState createState() => _BookingResultViewState();
}

class _BookingResultViewState extends State<BookingResultView> {
  late Future<BookingResponse> bookingResponse;

  @override
  void initState() {
    super.initState();
    bookingResponse = sendBookingRequest(widget.bookingRequest);
  }

  Future<BookingResponse> sendBookingRequest(
      BookingRequest bookingRequest) async {
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
    return BookingResponse(
      id: '123',
      tableId: '456',
      customerId: '789',
      bookingTime: DateTime.now().add(const Duration(days: 7)),
      isConfirmed: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<BookingResponse>(
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
              ListTile(
                title: Text('Booking ID: ${snapshot.data!.id}'),
              ),
              ListTile(
                title: Text(
                    'Date: ${snapshot.data!.bookingTime.toString().substring(0, 10)}'),
              ),
              ListTile(
                title: Text(
                    'Time: ${snapshot.data!.bookingTime.toString().substring(11, 16)}'),
              ),
              ListTile(
                title: Text(
                    'Confirmation: ${snapshot.data!.isConfirmed ? 'Confirmed' : 'Pending'}'),
              ),
              FilledButton(
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: const Text('Done'),
              ),
            ],
          );
        }
      },
    );
  }
}
