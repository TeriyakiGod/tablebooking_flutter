import 'package:flutter/material.dart';
import 'package:tablebooking_flutter/bookings/bookings_list.dart';
import 'package:tablebooking_flutter/models/booking.dart';
import 'package:tablebooking_flutter/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class BookingsView extends StatefulWidget {
  const BookingsView({super.key});
  @override
  BookingsViewState createState() => BookingsViewState();
}

class BookingsViewState extends State<BookingsView> {
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
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          return FutureBuilder<void>(
            future: authProvider.fetchUserInfo(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator(); // Show loading spinner while waiting for auth status
              } else {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  if (authProvider.isLoggedIn) {
                    return FutureBuilder<List<Booking>>(
                        future: bookings,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(child: Text('${snapshot.error}'));
                          } else {
                            return BookingsList(bookings: snapshot.data!);
                          }
                        });
                  } else {
                    return const Center(
                        child: Text('Please sign in to view your bookings'));
                  }
                }
              }
            },
          );
        },
      ),
    );
  }
}
