import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tablebooking_flutter/models/restaurant.dart';
import 'package:tablebooking_flutter/restaurant/restaurant_info.dart';
import 'package:url_launcher/url_launcher.dart';

class RestaurantHeader extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantHeader({
    super.key,
    required this.restaurant,
  });

  void _callRestaurant(BuildContext context) async {
    final restaurant = this.restaurant;
    final url = Uri(scheme: 'tel', path: restaurant.phone);

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
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildRestaurantImage(restaurant.primaryImageURL),
        RestaurantInfo(restaurant: restaurant),
        const Divider(),
        _buildActionChips(context),
        const Divider(),
      ],
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

  Widget _buildActionChips(context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Wrap(
        spacing: 8.0,
        children: [
          ActionChip(
            label: const Text("Call restaurant"),
            avatar: const Icon(Icons.phone),
            onPressed: () => _callRestaurant(context),
          ),
          const ActionChip(
            label: Text("View menu"),
            avatar: Icon(Icons.menu),
          ),
          const ActionChip(
            label: Text("Show on map"),
            avatar: Icon(Icons.map),
          ),
        ],
      ),
    );
  }
}
