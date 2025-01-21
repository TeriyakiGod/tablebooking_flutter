import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tablebooking_flutter/models/search_options.dart';
import 'package:tablebooking_flutter/search/list/restaurant_list.dart';
import 'package:tablebooking_flutter/search/tuning/tune.dart';
import 'package:tablebooking_flutter/providers/restaurant_provider.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  SearchState createState() => SearchState();
}

class SearchState extends State<Search> {
  SearchOptions searchOptions = SearchOptions.defaultOptions();
  final TextEditingController searchController = TextEditingController();
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<RestaurantProvider>(context, listen: false).fetchRestaurants();
    });
  }

  @override
  void dispose() {
    _debounceTimer?.cancel(); // Cancel the timer when the widget is disposed
    searchController.dispose(); // Dispose the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: const TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            RestaurantList(),
            Center(child: Text('Map view coming soon!')),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: _buildSearchBar(context),
      bottom: const TabBar(
        tabs: <Widget>[
          Tab(icon: Icon(Icons.list)),
          Tab(icon: Icon(Icons.map)),
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return SearchBar(
      controller: searchController, // Connect the controller
      constraints: const BoxConstraints(
        minHeight: 40,
        maxHeight: 40,
      ),
      leading: const Icon(Icons.search),
      trailing: [
        IconButton(
          icon: const Icon(Icons.tune),
          onPressed: () => _onTunePressed(context),
        ),
      ],
      hintText: 'Search for restaurants',
      onChanged: (value) => _onSearchChanged(context, value), // Use onChanged
    );
  }

  Future<void> _onTunePressed(BuildContext context) async {
    final result = await showDialog(
      context: context,
      builder: (context) => Dialog.fullscreen(
        child: Tune(searchOptions: searchOptions),
      ),
    );
    if (result != null) {
      setState(() {
        searchOptions = result;
      });
    }
  }

  void _onSearchChanged(BuildContext context, String query) {
    // Cancel the previous timer if it exists
    if (_debounceTimer?.isActive ?? false) {
      _debounceTimer?.cancel();
    }

    // Start a new timer
    _debounceTimer = Timer(const Duration(seconds: 1), () {
      // Fetch restaurants with the query after 1 second of inactivity
      Provider.of<RestaurantProvider>(context, listen: false)
          .fetchRestaurantsWithQuery(query: query);
    });
  }
}