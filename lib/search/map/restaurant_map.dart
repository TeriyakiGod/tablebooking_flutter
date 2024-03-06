import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tablebooking_flutter/models/restaurant.dart';
import 'package:tablebooking_flutter/restaurant_view.dart';

class RestaurantMap extends StatefulWidget {
  final List<Restaurant> restaurants;
  const RestaurantMap({super.key, required this.restaurants});

  @override
  _RestaurantMapState createState() => _RestaurantMapState();
}

class _RestaurantMapState extends State<RestaurantMap> {
  late GoogleMapController mapController;
  late Position currentPosition = Position(
    timestamp: DateTime.now(),
    accuracy: 0.0,
    altitude: 0.0,
    altitudeAccuracy: 0.0,
    heading: 0.0,
    headingAccuracy: 0.0,
    speed: 0.0,
    speedAccuracy: 0.0,
    latitude: 54.1944,
    longitude: 16.1722,
  );
  Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();
    _addRestaurantMarkers();
  }

  void _addRestaurantMarkers() {
    for (var restaurant in widget.restaurants) {
      markers.add(Marker(
        markerId: MarkerId(restaurant.name),
        position: LatLng(
            restaurant.location.latitude, restaurant.location.longitiude),
        infoWindow: InfoWindow(
            title: restaurant.name,
            snippet: restaurant.type,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RestaurantView(restaurant: restaurant),
                ),
              );
            }),
      ));
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: LatLng(currentPosition.latitude, currentPosition.longitude),
        zoom: 11.0,
      ),
      markers: markers,
    );
  }
}
