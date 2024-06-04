import 'package:flutter/material.dart';
import 'package:tablebooking_flutter/account/admin/create_restaurant_form.dart';
import 'package:tablebooking_flutter/account/admin/delete_restaurant_form.dart';

class AdminView extends StatefulWidget {
  const AdminView({super.key});

  @override
  AdminViewState createState() => AdminViewState();
}

class AdminViewState extends State<AdminView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin View'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Create'),
            Tab(text: 'Delete'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          // Create tab content
          CreateRestaurantForm(),
          // Delete tab content
          DeleteRestaurantForm()
        ],
      ),
    );
  }
}
