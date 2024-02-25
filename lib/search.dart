import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<String> restaurants = ['Restaurant 1', 'Restaurant 2', 'Restaurant 3'];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Row(
              children: <Widget>[
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: Icon(Icons.search),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.tune),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Options'),
                          content: Column(
                            children: <Widget>[
                              const Text('Sort By'),
                              const SizedBox(height: 10),
                              ToggleButtons(
                                isSelected: const [true, false, false],
                                children: const <Widget>[
                                  Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Text('Option 1'),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Text('Option 2'),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Text('Option 3'),
                                  ),
                                ],
                                onPressed: (int index) {},
                              ),
                              const SizedBox(height: 20),
                              const Text('Filter'),
                              const SizedBox(height: 10),
                              ToggleButtons(
                                isSelected: const [true, false, false],
                                children: const <Widget>[
                                  Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Text('Filter 1'),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Text('Filter 2'),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Text('Filter 3'),
                                  ),
                                ],
                                onPressed: (int index) {},
                              ),
                              const SizedBox(height: 20),
                              Slider(
                                value: 0.5,
                                onChanged: (double value) {},
                              ),
                            ],
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('Cancel'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: const Text('Apply'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
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
          body: TabBarView(
            children: <Widget>[
              ListView.builder(
                itemCount: restaurants.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: const Icon(Icons.restaurant),
                      title: Text(restaurants[index]),
                    ),
                  );
                },
              ),
              const Center(
                  child: Text('Map View')), // Replace this with your Map widget
            ],
          ),
        ));
  }
}
