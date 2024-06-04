import 'package:flutter/material.dart';

class DeleteRestaurantForm extends StatefulWidget {
  const DeleteRestaurantForm({super.key});

  @override
  DeleteRestaurantFormState createState() => DeleteRestaurantFormState();
}

class DeleteRestaurantFormState extends State<DeleteRestaurantForm> {
  final _formKey = GlobalKey<FormState>();

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
                  onSaved: (value) {},
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState?.save();
                      // TODO: Implement delete restaurant logic
                    }
                  },
                  child: const Text('Delete'),
                ),
              ],
            )));
  }
}
