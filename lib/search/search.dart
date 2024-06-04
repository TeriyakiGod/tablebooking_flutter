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
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: SearchBar(
            constraints: const BoxConstraints(
              minHeight: 40,
              maxHeight: 40,
            ),
            leading: const Icon(Icons.search),
            trailing: [
              IconButton(
                icon: const Icon(Icons.tune),
                onPressed: () async {
                  final result = await showDialog(
                    context: context,
                    builder: (context) => Dialog.fullscreen(
                      child: Tune(searchOptions: searchOptions),
                    ),
                  );
                  setState(() {
                    searchOptions = result;
                  });
                },
              )
            ],
            hintText: 'Search for restaurants',
            onSubmitted: (value) {
              Provider.of<RestaurantProvider>(context, listen: false)
                  .fetchAndSetRestaurantsWithQuery(query: value);
            },
          ),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.list),
              ),
              Tab(
                icon: Icon(Icons.map),
              ),
            ],
          ),
        ),
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
}
