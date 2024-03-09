import 'package:tablebooking_flutter/models/restaurant.dart';

class Booking {
  final String id;
  final String restaurantId;
  final String restaurantName;
  final String restaurantImage;
  final DateTime bookingTime;
  final bool isConfirmed;

  Booking({
    required this.id,
    required this.restaurantId,
    required this.restaurantName,
    required this.restaurantImage,
    required this.bookingTime,
    required this.isConfirmed,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'],
      restaurantId: json['restaurantId'],
      restaurantName: json['restaurantName'],
      restaurantImage: json['restaurantImage'],
      bookingTime: DateTime.parse(json['bookingTime']),
      isConfirmed: json['isConfirmed'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'restaurantId': restaurantId,
      'restaurantName': restaurantName,
      'restaurantImage': restaurantImage,
      'bookingTime': bookingTime.toIso8601String(),
      'isConfirmed': isConfirmed,
    };
  }

  static List<Booking> example() {
    return [
      Booking(
        id: '1',
        restaurantId: '1',
        restaurantName: 'Restaurant 1',
        restaurantImage: Restaurant.example()[1].primaryImageURL,
        bookingTime: DateTime.now().add(const Duration(days: 1)),
        isConfirmed: true,
      ),
      Booking(
        id: '2',
        restaurantId: '2',
        restaurantName: 'Restaurant 2',
        restaurantImage: Restaurant.example()[2].primaryImageURL,
        bookingTime: DateTime.now().add(const Duration(days: 2)),
        isConfirmed: false,
      ),
      Booking(
        id: '3',
        restaurantId: '3',
        restaurantName: 'Restaurant 3',
        restaurantImage: Restaurant.example()[3].primaryImageURL,
        bookingTime: DateTime.now().add(const Duration(days: 3)),
        isConfirmed: true,
      ),
    ];
  }
}
