import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tablebooking_flutter/models/booking.dart';
import 'package:tablebooking_flutter/providers/auth_provider.dart';
import 'package:provider/provider.dart';

import '../models/booking_request.dart';

class BookingProvider with ChangeNotifier {
  static final String _baseUrl =
      'https://tablebooking-api.kacperochnik.eu/Booking';
  List<Booking> _bookings = [];
  bool _isLoading = false;
  String? _error;

  List<Booking> get bookings => _bookings;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Helper method to handle loading state and notifications
  void _startLoading() {
    _isLoading = true;
    _error = null;
    notifyListeners();
  }

  void _stopLoading() {
    _isLoading = false;
    notifyListeners();
  }

  // Fetch all bookings
  Future<void> fetchBookings(BuildContext context) async {
    _startLoading();

    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final token = authProvider.token;

      if (token == null) {
        throw Exception('User is not authenticated');
      }

      final response = await http.get(
        Uri.parse('$_baseUrl/GetAllUserBookings'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        _bookings = data.map((json) => Booking.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load bookings: ${response.statusCode}');
      }
    } catch (e) {
      _error = e.toString();
      rethrow; // Rethrow to let the caller handle the exception
    } finally {
      _stopLoading();
    }
  }

  // Create a new booking
  Future<Booking> createBooking(BookingRequest bookingRequest,
      String restaurantId, BuildContext context) async {
    _startLoading();

    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final token = authProvider.token;

      if (token == null) {
        throw Exception('User is not authenticated');
      }

      final response = await http.post(
        Uri.parse('$_baseUrl/CreateBookingAutomatically/$restaurantId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(bookingRequest.toJson()),
      );

      if (response.statusCode == 201) {
        final newBooking = Booking.fromJson(json.decode(response.body));
        _bookings.add(newBooking);
        return newBooking;
      } else {
        throw Exception('Failed to create booking: ${response.statusCode}');
      }
    } catch (e) {
      _error = e.toString();
      rethrow;
    } finally {
      _stopLoading();
    }
  }

  // Update an existing booking
  Future<void> updateBooking(Booking booking, BuildContext context) async {
    _startLoading();

    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final token = authProvider.token;

      if (token == null) {
        throw Exception('User is not authenticated');
      }

      final response = await http.put(
        Uri.parse('$_baseUrl/UpdateBooking/${booking.id}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(booking.toJson()),
      );

      if (response.statusCode == 200) {
        final updatedBooking = Booking.fromJson(json.decode(response.body));
        final index = _bookings.indexWhere((b) => b.id == updatedBooking.id);
        if (index != -1) {
          _bookings[index] = updatedBooking;
        }
      } else {
        throw Exception('Failed to update booking: ${response.statusCode}');
      }
    } catch (e) {
      _error = e.toString();
      rethrow;
    } finally {
      _stopLoading();
    }
  }

  // Delete a booking
  Future<void> deleteBooking(String bookingId, BuildContext context) async {
    _startLoading();

    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final token = authProvider.token;

      if (token == null) {
        throw Exception('User is not authenticated');
      }

      final response = await http.delete(
        Uri.parse('$_baseUrl/DeleteBooking/$bookingId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 204) {
        _bookings.removeWhere((booking) => booking.id == bookingId);
      } else {
        throw Exception('Failed to delete booking: ${response.statusCode}');
      }
    } catch (e) {
      _error = e.toString();
      rethrow;
    } finally {
      _stopLoading();
    }
  }

  // Fetch a single booking by ID
  Future<Booking?> fetchBookingById(
      String bookingId, BuildContext context) async {
    _startLoading();

    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final token = authProvider.token;

      if (token == null) {
        throw Exception('User is not authenticated');
      }

      final response = await http.get(
        Uri.parse('$_baseUrl/GetBookingById/$bookingId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return Booking.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load booking: ${response.statusCode}');
      }
    } catch (e) {
      _error = e.toString();
      rethrow;
    } finally {
      _stopLoading();
    }
  }
}
