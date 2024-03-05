import 'dart:math';

import 'package:tablebooking_flutter/models/price.dart';

class Restaurant {
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
  static Restaurant example() {
    var random = Random().nextInt(1000);
    return Restaurant(
      name: 'Restaurant Name',
      type: 'Restaurant Type',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean lacinia eu arcu vitae malesuada. Pellentesque sed velit auctor, egestas nisi quis, tincidunt odio. Aenean nec neque mi. Fusce malesuada erat ac est placerat gravida. Vestibulum vel massa maximus, tincidunt mi a, luctus massa. Fusce at velit eu nulla pharetra imperdiet. Aenean finibus tellus sed posuere varius. Mauris imperdiet nibh purus, sed aliquet erat pharetra sed. Mauris sit amet elit efficitur, tincidunt odio vitae, hendrerit sapien. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean lacinia eu arcu vitae malesuada. Pellentesque sed velit auctor, egestas nisi quis, tincidunt odio. Aenean nec neque mi. Fusce malesuada erat ac est placerat gravida. Vestibulum vel massa maximus, tincidunt mi a, luctus massa. Fusce at velit eu nulla pharetra imperdiet. Aenean finibus tellus sed posuere varius. Mauris imperdiet nibh purus, sed aliquet erat pharetra sed. Mauris sit amet elit efficitur, tincidunt odio vitae, hendrerit sapien. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean lacinia eu arcu vitae malesuada. Pellentesque sed velit auctor, egestas nisi quis, tincidunt odio. Aenean nec neque mi. Fusce malesuada erat ac est placerat gravida. Vestibulum vel massa maximus, tincidunt mi a, luctus massa. Fusce at velit eu nulla pharetra imperdiet. Aenean finibus tellus sed posuere varius. Mauris imperdiet nibh purus, sed aliquet erat pharetra sed. Mauris sit amet elit efficitur, tincidunt odio vitae, hendrerit sapien. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean lacinia eu arcu vitae malesuada. Pellentesque sed velit auctor, egestas nisi quis, tincidunt odio. Aenean nec neque mi. Fusce malesuada erat ac est placerat gravida. Vestibulum vel massa maximus, tincidunt mi a, luctus massa. Fusce at velit eu nulla pharetra imperdiet. Aenean finibus tellus sed posuere varius. Mauris imperdiet nibh purus, sed aliquet erat pharetra sed. Mauris sit amet elit efficitur, tincidunt odio vitae, hendrerit sapien.',
      location: 'Restaurant Location',
      phone: '+48 128732123',
      primaryImageURL: 'https://picsum.photos/seed/$random/200/300',
      secondaryImageURL: 'https://picsum.photos/$random/200/300',
      rating: 3.5,
      price: Price.medium,
      openTime: DateTime.utc(2021, 1, 1, 8, 0, 0),
      closeTime: DateTime.utc(2021, 1, 1, 21, 0, 0),
    );
  }

  static List<Restaurant> exampleList() {
    return [
      Restaurant.example(),
      Restaurant.example(),
      Restaurant.example(),
    ];
  }
}
