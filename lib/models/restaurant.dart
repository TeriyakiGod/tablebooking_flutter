import 'package:tablebooking_flutter/models/price.dart';

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
  final Location location;
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
      id: json['Id'],
      name: json['Name'],
      type: json['Type'],
      description: json['Description'],
      location: json['Location'],
      phone: json['Phone'],
      primaryImageURL: json['PrimaryImageURL'],
      secondaryImageURL: json['SecondaryImageURL'],
      rating: json['Rating'].toDouble(),
      price: json['Price'],
      openTime: DateTime.parse(json['OpenTime']),
      closeTime: DateTime.parse(json['CloseTime']),
    );
  }
  static List<Restaurant> example() {
    return [
      Restaurant(
        id: '1',
        name: 'Nienażarty',
        type: 'Hamburger',
        description: 'Najlepsze burgery w mieście',
        location: Location(
            longitiude: 16.205419735398273, latitude: 54.190559369010174),
        phone: '1234567890',
        primaryImageURL: 'https://picsum.photos/id/10/1920/1080',
        secondaryImageURL: 'https://picsum.photos/id/238/200/300',
        rating: 4,
        price: Price.high,
        openTime: DateTime.utc(0, 0, 0, 8, 0),
        closeTime: DateTime.utc(0, 0, 0, 22, 0),
      ),
      Restaurant(
        id: '2',
        name: 'Pizzeria Tre Pomodori',
        type: 'Pizza',
        description: 'Najlepsze pizze w mieście',
        location: Location(
            longitiude: 16.204880430605304, latitude: 54.196277506404655),
        phone: '1234567890',
        primaryImageURL: 'https://picsum.photos/id/15/1920/1080',
        secondaryImageURL: 'https://picsum.photos/id/213/200/300',
        rating: 5,
        price: Price.medium,
        openTime: DateTime.utc(0, 0, 0, 14, 0),
        closeTime: DateTime.utc(0, 0, 0, 22, 0),
      ),
      Restaurant(
        id: '3',
        name: 'AMBASADA',
        type: 'Thai',
        description: 'Fajna kuchnia azjatycka',
        location: Location(
            longitiude: 16.19371022315012, latitude: 54.19974951669606),
        phone: '1234567890',
        primaryImageURL: 'https://picsum.photos/id/999/1920/1080',
        secondaryImageURL: 'https://picsum.photos/id/203/200/300',
        rating: 3,
        price: Price.low,
        openTime: DateTime.utc(0, 0, 0, 10, 0),
        closeTime: DateTime.utc(0, 0, 0, 22, 0),
      ),
    ];
  }
}
