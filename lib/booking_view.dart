import 'package:flutter/material.dart';
import 'package:tablebooking_flutter/models/restaurant.dart';
import 'package:tablebooking_flutter/number_picker.dart';
import 'package:tablebooking_flutter/search/list/restaurant_info.dart';

class BookingView extends StatefulWidget {
  final Restaurant? restaurant;
  final String? restaurantId;

  BookingView({super.key, this.restaurant, this.restaurantId}) {
    if (restaurant == null && restaurantId == null) {
      throw ArgumentError(
          'You must provide either a restaurant or a restaurantId');
    }
  }
  @override
  _BookingViewState createState() => _BookingViewState();
}

class _BookingViewState extends State<BookingView> {
  late Future<Restaurant> restaurant;
  TimeOfDay selectedTime = TimeOfDay.now();
  DateTime selectedDate = DateTime.now();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  bool isDatePicked = false;

  @override
  void initState() {
    super.initState();
    restaurant = widget.restaurant != null
        ? Future.value(widget.restaurant)
        : fetchRestaurant();
  }

  Future<Restaurant> fetchRestaurant() async {
    // final response = await http.get(
    //     Uri.parse('http://mybackend.com/restaurants/${widget.restaurantId}'));

    // if (response.statusCode == 200) {
    //   // If the server returns a 200 OK response, then parse the JSON.
    //   return Restaurant.fromJson(jsonDecode(response.body));
    // } else {
    //   // If the server did not return a 200 OK response, then throw an exception.
    //   throw Exception('Failed to load restaurant');
    // }
    return Restaurant.example()
        .firstWhere((element) => element.id == widget.restaurantId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Restaurant>(
      future: restaurant,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Book a table"),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.network(
                  snapshot.data!.primaryImageURL,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200,
                ),
                RestaurantInfo(restaurant: snapshot.data!),
                const Divider(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TextFormField(
                        readOnly: true,
                        controller: dateController,
                        decoration: const InputDecoration(
                          labelText: 'Select Date',
                        ),
                        onTap: () async {
                          final DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: selectedDate,
                            firstDate: selectedDate,
                            lastDate:
                                selectedDate.add(const Duration(days: 90)),
                          );
                          if (pickedDate != null &&
                              pickedDate != selectedDate) {
                            setState(() {
                              selectedDate = pickedDate;
                              dateController.text =
                                  selectedDate.toString().substring(0, 10);
                              isDatePicked = true;
                            });
                          }
                        },
                      ),
                      TextFormField(
                          enabled: isDatePicked,
                          readOnly: true,
                          controller: timeController,
                          decoration: const InputDecoration(
                            labelText: 'Select Time',
                          ),
                          onTap: () async {
                            final TimeOfDay? pickedTime = await showTimePicker(
                              context: context,
                              initialTime: selectedTime,
                            );
                            if (pickedTime != null &&
                                pickedTime != selectedTime) {
                              final DateTime now = DateTime.now();
                              final DateTime currentTime = DateTime(now.year,
                                  now.month, now.day, now.hour, now.minute);
                              final DateTime selectedDateTime = DateTime(
                                  selectedDate.year,
                                  selectedDate.month,
                                  selectedDate.day,
                                  pickedTime.hour,
                                  pickedTime.minute);

                              if (selectedDateTime
                                      .difference(currentTime)
                                      .inMinutes <
                                  120) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'Selected time must be at least 2 hours from now.'),
                                  ),
                                );
                              } else {
                                setState(() {
                                  selectedTime = pickedTime;
                                  timeController.text =
                                      selectedTime.format(context);
                                });
                              }
                            }
                          }),
                      Row(
                        children: [
                          Text(
                            "Guests: ",
                            style: Theme.of(context)
                                .inputDecorationTheme
                                .labelStyle,
                          ),
                          const NumberPicker(limit: 10)
                        ],
                      ),
                      FilledButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Booking confirmed!'),
                            ),
                          );
                        },
                        child: const Text('Book'),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        // By default, show a loading spinner.
        return const CircularProgressIndicator();
      },
    );
  }
}
