import 'package:flutter/material.dart';
import 'package:tablebooking_flutter/bookings/bookings_list.dart';
import 'package:tablebooking_flutter/models/booking.dart';

class BookingsView extends StatefulWidget {
  const BookingsView({super.key});
  @override
  _BookingsViewState createState() => _BookingsViewState();
}

class _BookingsViewState extends State<BookingsView> {
  late Future<List<Booking>> bookings;

  @override
  void initState() {
    super.initState();
    bookings = fetchBookings();
  }

  Future<List<Booking>> fetchBookings() async {
    // TODO: Replace with actual API call, integrate with searchOptions
    // final response = await http.get(
    //     Uri.parse('http://mybackend.com/restaurants'));

    // if (response.statusCode == 200) {
    //   // If the server returns a 200 OK response, then parse the JSON.
    //   return Restaurant.fromJson(jsonDecode(response.body));
    // } else {
    //   // If the server did not return a 200 OK response, then throw an exception.
    //   throw Exception('Failed to load restaurant');
    // }
    await Future.delayed(const Duration(seconds: 1));
    return Booking.example();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My bookings'),
      ),
      body: FutureBuilder<List<Booking>>(
        future: bookings,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'));
          } else {
            return BookingsList(bookings: snapshot.data!);
          }
        },
      ),
    );
  }
}
