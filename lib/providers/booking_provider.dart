import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tablebooking_flutter/models/booking.dart';
import 'package:tablebooking_flutter/providers/auth_provider.dart';
import 'package:provider/provider.dart';

import '../models/booking_request.dart';

class BookingProvider with ChangeNotifier {
  static String get baseUrl => dotenv.env['API_URL'] ?? 'http://localhost:8080';
  List<Booking> _bookings = [];
  bool _isLoading = false;
  String? _error;

  List<Booking> get bookings => _bookings;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Fetch all bookings
  Future<void> fetchBookings(BuildContext context) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Get the Bearer token from AuthProvider
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final token = authProvider.token;

      if (token == null) {
        throw Exception('User is not authenticated');
      }

      final response = await http.get(
        Uri.parse('$baseUrl/Booking/GetAllUserBookings'),
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
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<Booking> createBooking(BookingRequest bookingRequest,
      String restaurantId, BuildContext context) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Get the Bearer token from AuthProvider
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final token = authProvider.token;

      if (token == null) {
        throw Exception('User is not authenticated');
      }

      // Convert BookingRequest to JSON
      final requestBody = bookingRequest.toJson();

      final response = await http.post(
        Uri.parse('$baseUrl/Booking/CreateBooking/$restaurantId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(requestBody), // Pass the BookingRequest as JSON
      );

      if (response.statusCode == 201) {
        final newBooking = Booking.fromJson(json.decode(response.body));
        _bookings.add(newBooking);
        return newBooking; // Return the newly created booking
      } else {
        throw Exception('Failed to create booking: ${response.statusCode}');
      }
    } catch (e) {
      _error = e.toString();
      rethrow; // Rethrow the exception to let the caller handle it
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Update an existing booking
  Future<void> updateBooking(Booking booking, BuildContext context) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Get the Bearer token from AuthProvider
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final token = authProvider.token;

      if (token == null) {
        throw Exception('User is not authenticated');
      }

      final response = await http.put(
        Uri.parse('$baseUrl/Booking/UpdateBooking/${booking.id}'),
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
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Delete a booking
  Future<void> deleteBooking(String bookingId, BuildContext context) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Get the Bearer token from AuthProvider
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final token = authProvider.token;

      if (token == null) {
        throw Exception('User is not authenticated');
      }

      final response = await http.delete(
        Uri.parse('$baseUrl/Booking/DeleteBooking/$bookingId'),
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
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Fetch a single booking by ID
  Future<Booking?> fetchBookingById(
      String bookingId, BuildContext context) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Get the Bearer token from AuthProvider
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final token = authProvider.token;

      if (token == null) {
        throw Exception('User is not authenticated');
      }

      final response = await http.get(
        Uri.parse('$baseUrl/Booking/GetBookingById/$bookingId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final booking = Booking.fromJson(json.decode(response.body));
        return booking;
      } else {
        throw Exception('Failed to load booking: ${response.statusCode}');
      }
    } catch (e) {
      _error = e.toString();
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
