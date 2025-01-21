import 'package:flutter/material.dart';
import 'package:tablebooking_flutter/bookings/bookings_list.dart';
import 'package:tablebooking_flutter/providers/auth_provider.dart';
import 'package:tablebooking_flutter/providers/booking_provider.dart';
import 'package:provider/provider.dart';

class BookingsView extends StatefulWidget {
  const BookingsView({super.key});

  @override
  BookingsViewState createState() => BookingsViewState();
}

class BookingsViewState extends State<BookingsView> {
  @override
  void initState() {
    super.initState();
    // Fetch bookings when the view is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (Provider.of<AuthProvider>(context, listen: false).isLoggedIn) {
        Provider.of<BookingProvider>(context, listen: false)
            .fetchBookings(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My bookings'),
      ),
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          if (authProvider.isLoading) {
            return const Center(
                child: CircularProgressIndicator()); // Show loading spinner
          } else if (!authProvider.isLoggedIn) {
            return const Center(
              child: Text('Please sign in to view your bookings'),
            ); // Show sign-in prompt
          } else {
            return _buildBookingsList(); // Show bookings list
          }
        },
      ),
    );
  }

  // Bookings List
  Widget _buildBookingsList() {
    return Consumer<BookingProvider>(
      builder: (context, bookingProvider, child) {
        if (bookingProvider.isLoading) {
          return const Center(
              child: CircularProgressIndicator()); // Show loading spinner
        } else if (bookingProvider.error != null) {
          return Center(
              child: Text(
                  'Error: ${bookingProvider.error}')); // Show error message
        } else if (bookingProvider.bookings.isEmpty) {
          return const Center(
              child: Text('No bookings found.')); // Show empty state
        } else {
          return BookingsList(
              bookings: bookingProvider.bookings); // Show bookings list
        }
      },
    );
  }
}
