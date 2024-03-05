import 'package:tablebooking_flutter/models/price.dart';

class Restaurant {
  final String name;
  final String type;
  final String? description;
  final String location;
  final String phone;
  final String? primaryImageURL;
  final String? secondaryImageURL;
  final double rating;
  final Price price;
  final DateTime openTime;
  final DateTime closeTime;

  Restaurant({
    required this.name,
    required this.type,
    this.description,
    required this.location,
    required this.phone,
    this.primaryImageURL,
    this.secondaryImageURL,
    required this.rating,
    required this.price,
    required this.openTime,
    required this.closeTime,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
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
}
