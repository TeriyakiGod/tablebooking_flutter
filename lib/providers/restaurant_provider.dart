import 'dart:collection';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tablebooking_flutter/models/restaurant.dart';
import 'package:http/http.dart' as http;

// TODO: Create GENERIC API provider class
class RestaurantProvider with ChangeNotifier {
  static final String _baseUrl = "https://tablebooking-api.kacperochnik.eu/Restaurant";
  bool _isLoading = false;
  String _error = '';
  List<Restaurant> _restaurants = [];

  UnmodifiableListView<Restaurant> get restaurants =>
      UnmodifiableListView(_restaurants);
  bool get isLoading => _isLoading;
  String get error => _error;

  // Fetch all restaurants from the API
  Future<void> fetchRestaurants() async {
    _isLoading = true;
    _error = '';
    notifyListeners();
    try {
      final response =
          await http.get(Uri.parse("$_baseUrl/GetAllRestaurants"));
      if (response.statusCode == 200) {
        List<dynamic> list = jsonDecode(response.body);
        _restaurants = list.map((e) {return Restaurant.fromJson(e);}).toList();
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching restaurants: $e');
      throw Exception('Failed to load data: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Fetch restaurants with a search query
  Future<void> fetchRestaurantsWithQuery({String? query}) async {
    try {
      final response =
          await http.get(Uri.parse("$_baseUrl/GetAllRestaurants"));

      if (response.statusCode == 200) {
        List<dynamic> list = jsonDecode(response.body);
        _restaurants = list.map((e) => Restaurant.fromJson(e)).toList();
        // Apply the query filter if provided
        if (query != null) {
          _restaurants = _restaurants
              .where((element) =>
                  element.name.toLowerCase().contains(query.toLowerCase()))
              .toList();
        }
        notifyListeners(); // Notify listeners after updating the list
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching restaurants with query: $e');
      throw Exception('Failed to load data: $e');
    }
  }

  // Fetch a single restaurant by ID
  Future<Restaurant> fetchRestaurantById(String restaurantId) async {
    final url =
        Uri.parse('$_baseUrl/GetRestaurantById/$restaurantId');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return Restaurant.fromJson(data);
      } else {
        throw Exception('Failed to load restaurant: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load restaurant: $e');
    }
  }

  // Add a new restaurant via the API
  Future<void> addRestaurant(Restaurant restaurant) async {
    try {
      final response = await http.post(
        Uri.parse("$_baseUrl/AddRestaurant"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(restaurant.toJson()),
      );

      if (response.statusCode == 201) {
        // If the restaurant is successfully added, fetch the updated list
        await fetchRestaurants();
      } else {
        throw Exception('Failed to add restaurant: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error adding restaurant: $e');
      throw Exception('Failed to add restaurant: $e');
    }
  }

  // Update an existing restaurant via the API
  Future<void> updateRestaurant(Restaurant restaurant) async {
    try {
      final response = await http.put(
        Uri.parse("$_baseUrl/UpdateRestaurant/${restaurant.id}"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(restaurant.toJson()),
      );

      if (response.statusCode == 200) {
        // If the restaurant is successfully updated, fetch the updated list
        await fetchRestaurants();
      } else {
        throw Exception('Failed to update restaurant: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error updating restaurant: $e');
      throw Exception('Failed to update restaurant: $e');
    }
  }

  // Delete a restaurant via the API
  Future<void> deleteRestaurant(String id) async {
    try {
      final response = await http.delete(
        Uri.parse("$_baseUrl/DeleteRestaurant/$id"),
      );

      if (response.statusCode == 200) {
        // If the restaurant is successfully deleted, fetch the updated list
        await fetchRestaurants();
      } else {
        throw Exception('Failed to delete restaurant: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error deleting restaurant: $e');
      throw Exception('Failed to delete restaurant: $e');
    }
  }
}
