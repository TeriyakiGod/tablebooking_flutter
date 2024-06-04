import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tablebooking_flutter/providers/restaurant_provider.dart';

class DeleteRestaurantForm extends StatefulWidget {
  const DeleteRestaurantForm({super.key});

  @override
  DeleteRestaurantFormState createState() => DeleteRestaurantFormState();
}

class DeleteRestaurantFormState extends State<DeleteRestaurantForm> {
  final _formKey = GlobalKey<FormState>();
  String restaurantName = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Restaurant Name',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the restaurant name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    restaurantName = value!;
                  },
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    final isValid = _formKey.currentState?.validate();
                    if (!isValid!) {
                      return;
                    }
                    _formKey.currentState?.save();
                    Provider.of<RestaurantProvider>(context, listen: false)
                        .deleteRestaurant(restaurantName);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Restaurant deleted!')),
                    );
                    Navigator.of(context).pop();
                  },
                  child: const Text('Delete'),
                ),
              ],
            )));
  }
}
