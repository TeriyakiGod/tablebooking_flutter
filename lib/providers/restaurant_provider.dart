import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:tablebooking_flutter/models/restaurant.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class RestaurantProvider extends ChangeNotifier {

  static String get baseUrl => dotenv.env['API_URL']??'http://localhost:8080';
      
  List<Restaurant> _restaurants = [];
  List<Restaurant> get restaurants => _restaurants;

  //fetch after object creation
  RestaurantProvider() {
    fetchAndSetRestaurants();
  }

  Future<void> fetchAndSetRestaurants() async {
    final response = await http.get(Uri.parse("$baseUrl/Restaurant/GetAllRestaurants"));

    if (response.statusCode == 200) {
      List<dynamic> list = jsonDecode(response.body);
      _restaurants = list.map((e) => Restaurant.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }

    notifyListeners();
  }

  void fetchAndSetRestaurantsWithQuery({String? query}) {
    var storedRestaurants = localStorage.getItem('restaurants');
    if (storedRestaurants != null) {
      List<dynamic> list = jsonDecode(storedRestaurants);
      _restaurants = list.map((e) => Restaurant.fromJson(e)).toList();
      if (query != null) {
        _restaurants = _restaurants
            .where((element) => element.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    } else {
      _restaurants = Restaurant.example();
      localStorage.setItem('restaurants', jsonEncode(_restaurants));
      if (query != null) {
        _restaurants = _restaurants
            .where((element) => element.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    }
    notifyListeners();
  }

  void addRestaurant(Restaurant restaurant) {
    _restaurants.add(restaurant);
    localStorage.setItem('restaurants', jsonEncode(_restaurants));
    notifyListeners();
  }

  void updateRestaurant(Restaurant restaurant) {
    var index = _restaurants
        .indexWhere((element) => element.hashCode == restaurant.hashCode);
    if (index != -1) {
      _restaurants[index] = restaurant;
      localStorage.setItem('restaurants', jsonEncode(_restaurants));
      notifyListeners();
    }
  }

  void deleteRestaurant(String name) {
    _restaurants.removeWhere((element) => element.name == name);
    localStorage.setItem('restaurants', jsonEncode(_restaurants));
    notifyListeners();
  }
}
