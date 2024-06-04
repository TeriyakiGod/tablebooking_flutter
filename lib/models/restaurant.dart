import 'package:tablebooking_flutter/models/search_options.dart';

class Location {
  final double longitiude;
  final double latitude;

  Location({required this.longitiude, required this.latitude});
}

class Restaurant {
  final String id;
  final String name;
  final String type;
  final String description;
  final String location;
  final String phone;
  final String primaryImageURL;
  final String secondaryImageURL;
  final double rating;
  final Price price;
  final DateTime openTime;
  final DateTime closeTime;

  Restaurant({
    required this.id,
    required this.name,
    required this.type,
    required this.description,
    required this.location,
    required this.phone,
    required this.primaryImageURL,
    required this.secondaryImageURL,
    required this.rating,
    required this.price,
    required this.openTime,
    required this.closeTime,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      type: json['type'] ?? '',
      description: json['description'] ?? '',
      location: json['location'] ?? '',
      phone: json['phone'] ?? '',
      primaryImageURL: json['primaryImageURL'] ?? '',
      secondaryImageURL: json['secondaryImageURL'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
      price: Price.values[json['price'] ?? 0], // Convert int to Price enum
      openTime: DateTime.parse(json['openTime'] ?? '1970-01-01T00:00:00Z'),
      closeTime: DateTime.parse(json['closeTime'] ?? '1970-01-01T00:00:00Z'),
    );
  }

  static List<Restaurant> example() {
    return [
      Restaurant(
        id: '1',
        name: 'Nienażarty',
        type: 'Hamburger',
        description: 'Najlepsze burgery w mieście',
        location: "ul. Wrocławska 1, 50-100 Wrocław",
        phone: '1234567890',
        primaryImageURL: 'https://picsum.photos/id/10/1920/1080',
        secondaryImageURL: 'https://picsum.photos/id/238/200/300',
        rating: 4.23,
        price: Price.high,
        openTime: DateTime.utc(0, 0, 0, 8, 0),
        closeTime: DateTime.utc(0, 0, 0, 21, 0),
      ),
      Restaurant(
        id: '2',
        name: 'Pizzeria Tre Pomodori',
        type: 'Pizza',
        description: 'Najlepsze pizze w mieście',
        location: "ul. Wrocławska 1, 50-100 Wrocław",
        phone: '1234567890',
        primaryImageURL: 'https://picsum.photos/id/15/1920/1080',
        secondaryImageURL: 'https://picsum.photos/id/213/200/300',
        rating: 4.5,
        price: Price.medium,
        openTime: DateTime.utc(0, 0, 0, 14, 0),
        closeTime: DateTime.utc(0, 0, 0, 22, 0),
      ),
      Restaurant(
        id: '3',
        name: 'AMBASADA',
        type: 'Thai',
        description: 'Fajna kuchnia azjatycka',
        location: "ul. Wrocławska 1, 50-100 Wrocław",
        phone: '1234567890',
        primaryImageURL: 'https://picsum.photos/id/999/1920/1080',
        secondaryImageURL: 'https://picsum.photos/id/203/200/300',
        rating: 3.2,
        price: Price.low,
        openTime: DateTime.utc(0, 0, 0, 10, 0),
        closeTime: DateTime.utc(0, 0, 0, 22, 0),
      ),
    ];
  }
}
