import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tablebooking_flutter/providers/restaurant_provider.dart';
import 'package:tablebooking_flutter/models/restaurant.dart';
import 'package:tablebooking_flutter/search/list/rating.dart';
import 'package:tablebooking_flutter/search/list/restaurant_info.dart';
import 'package:tablebooking_flutter/restaurant/book/book_view.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import '../providers/auth_provider.dart';

class RestaurantView extends StatefulWidget {
  final Restaurant? restaurant;
  final String? restaurantId;

  RestaurantView({super.key, this.restaurant, this.restaurantId}) {
    if (restaurant == null && restaurantId == null) {
      throw ArgumentError(
          'You must provide either a restaurant or a restaurantId');
    }
  }

  @override
  RestaurantViewState createState() => RestaurantViewState();
}

class RestaurantViewState extends State<RestaurantView> {
  late Future<Restaurant> _restaurantFuture;

  void _callRestaurant() async {
    final restaurant = widget.restaurant;
    final url = Uri(scheme: 'tel', path: restaurant!.phone);

    if (kIsWeb) {
      // If running on the web, just display the phone number
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Call Restaurant'),
          content: Text('Phone: ${restaurant.phone}'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else {
      // If running on a mobile device, launch the phone dialer
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _restaurantFuture = widget.restaurant != null
        ? Future.value(widget.restaurant)
        : _fetchRestaurant();
  }

  Future<Restaurant> _fetchRestaurant() async {
    final restaurantProvider =
        Provider.of<RestaurantProvider>(context, listen: false);
    return await restaurantProvider.fetchRestaurantById(widget.restaurantId!);
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          } else {
            GoRouter.of(context).go('/search');
          }
        },
      ),
      title: const Text("Restaurant"),
    );
  }

  Widget _buildRestaurantImage(String imageUrl) {
    return Image.network(
      imageUrl,
      fit: BoxFit.cover,
      width: double.infinity,
      height: 200,
    );
  }

  Widget _buildActionChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Wrap(
        spacing: 8.0,
        children: [
          ActionChip(
            label: Text("Call restaurant"),
            avatar: Icon(Icons.phone),
            onPressed: _callRestaurant,
          ),
          ActionChip(
            label: Text("View menu"),
            avatar: Icon(Icons.menu),
          ),
          ActionChip(
            label: Text("Show on map"),
            avatar: Icon(Icons.map),
          ),
        ],
      ),
    );
  }

  // TODO: Finish comments/ratings section
  Widget _buildScrollableSection(String description) {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
              description,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
              ),
            ),
            const Divider(),
            _buildCommentsSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildCommentsSection() {
    // Placeholder for comments section
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 10.0),
          child: Text(
            'Reviews',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      const SizedBox(height: 10),
      ListTile(
        leading: CircleAvatar(
          child: Text('A'),
        ),
        title: Text('Alice'),
        subtitle: Text('Great food and excellent service!'),
        trailing: Rating(rating: 4.5),
      ),
      ListTile(
        leading: CircleAvatar(
          child: Text('B'),
        ),
        title: Text('Bob'),
        subtitle: Text('Loved the ambiance and the food was delicious.'),
        trailing: Rating(rating: 4.0),
      ),
      ListTile(
        leading: CircleAvatar(
          child: Text('C'),
        ),
        title: Text('Charlie'),
        subtitle: Text('A bit pricey, but worth it for the quality.'),
        trailing: Rating(rating: 3.5),
      ),
      ],
    );
  }

  Widget _buildFloatingActionButton(
      BuildContext context, Restaurant restaurant) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        if (authProvider.isLoggedIn) {
          return FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookView(restaurant: restaurant),
                ),
              );
            },
            label: const Text("Book a table"),
            icon: const Icon(Icons.table_restaurant),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Restaurant>(
      future: _restaurantFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final restaurant = snapshot.data!;
          return Scaffold(
            appBar: _buildAppBar(context),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildRestaurantImage(restaurant.primaryImageURL),
                RestaurantInfo(restaurant: restaurant),
                const Divider(),
                _buildActionChips(),
                const Divider(),
                _buildScrollableSection(restaurant.description),
              ],
            ),
            floatingActionButton:
                _buildFloatingActionButton(context, restaurant),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: _buildAppBar(context),
            body: Center(
              child: Text("Error: ${snapshot.error}"),
            ),
          );
        }
        // By default, show a loading spinner.
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
