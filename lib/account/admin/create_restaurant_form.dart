import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tablebooking_flutter/models/restaurant.dart';
import 'package:tablebooking_flutter/models/search_options.dart';
import 'package:tablebooking_flutter/providers/restaurant_provider.dart';

class CreateRestaurantForm extends StatefulWidget {
  const CreateRestaurantForm({super.key});

  @override
  CreateRestaurantFormState createState() => CreateRestaurantFormState();
}

class CreateRestaurantFormState extends State<CreateRestaurantForm> {
  Restaurant restaurant = Restaurant.example().first;
  final _formKey = GlobalKey<FormState>();

  void pickOpeningDateAndTime() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    ).then((DateTime? date) {
      if (date != null) {
        showTimePicker(
          context: context,
          initialTime: TimeOfDay.fromDateTime(restaurant.openTime),
        ).then((TimeOfDay? time) {
          if (time != null) {
            setState(() {
              restaurant.openTime = DateTime(
                date.year,
                date.month,
                date.day,
                time.hour,
                time.minute,
              );
            });
          }
        });
      }
    });
  }

  void pickClosingDateAndTime() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    ).then((DateTime? date) {
      if (date != null) {
        showTimePicker(
          context: context,
          initialTime: TimeOfDay.fromDateTime(restaurant.closeTime),
        ).then((TimeOfDay? time) {
          if (time != null) {
            setState(() {
              restaurant.closeTime = DateTime(
                date.year,
                date.month,
                date.day,
                time.hour,
                time.minute,
              );
            });
          }
        });
      }
    });
  }

  void saveForm() {
    final isValid = _formKey.currentState?.validate();
    if (!isValid!) {
      return;
    }
    _formKey.currentState?.save();
    Provider.of<RestaurantProvider>(context, listen: false)
        .addRestaurant(restaurant);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Restaurant created!')),
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Name'),
              initialValue: restaurant.name,
              onChanged: (value) {
                setState(() {
                  restaurant.name = value;
                });
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Type'),
              initialValue: restaurant.type,
              onChanged: (value) {
                setState(() {
                  restaurant.type = value;
                });
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Description'),
              initialValue: restaurant.description,
              onChanged: (value) {
                setState(() {
                  restaurant.description = value;
                });
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Location'),
              initialValue: restaurant.location,
              onChanged: (value) {
                setState(() {
                  restaurant.location = value;
                });
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Phone'),
              initialValue: restaurant.phone,
              onChanged: (value) {
                setState(() {
                  restaurant.phone = value;
                });
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Primary image URL'),
              initialValue: restaurant.primaryImageURL,
              onChanged: (value) {
                setState(() {
                  restaurant.primaryImageURL = value;
                });
              },
            ),
            TextFormField(
              decoration:
                  const InputDecoration(labelText: 'Secondary image URL'),
              initialValue: restaurant.secondaryImageURL,
              onChanged: (value) {
                setState(() {
                  restaurant.secondaryImageURL = value;
                });
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Rating'),
              initialValue: restaurant.rating.toString(),
              onChanged: (value) {
                setState(() {
                  restaurant.rating = double.parse(value);
                });
              },
            ),
            DropdownButtonFormField<Price>(
              decoration: const InputDecoration(labelText: 'Price'),
              value: restaurant.price,
              onChanged: (Price? value) {
                setState(() {
                  restaurant.price = value!;
                });
              },
              items: Price.values.map((Price price) {
                return DropdownMenuItem<Price>(
                  value: price,
                  child: Text(price.toString()),
                );
              }).toList(),
            ),
            Row(
              children: [
                Text('Open Time: ${restaurant.openTime}'),
                TextButton(
                  onPressed: pickOpeningDateAndTime,
                  child: const Text('Pick'),
                ),
              ],
            ),
            Row(
              children: [
                Text('Close Time: ${restaurant.closeTime}'),
                TextButton(
                  onPressed: pickClosingDateAndTime,
                  child: const Text('Pick'),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: saveForm,
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
