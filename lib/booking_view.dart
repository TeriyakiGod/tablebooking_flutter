import 'package:flutter/material.dart';
import 'package:tablebooking_flutter/booking_help.dart';
import 'package:tablebooking_flutter/models/booking_request.dart';
import 'package:tablebooking_flutter/models/restaurant.dart';
import 'package:tablebooking_flutter/number_picker.dart';
import 'package:tablebooking_flutter/search/list/restaurant_info.dart';
import 'package:tablebooking_flutter/booking_result_view.dart';

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
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  bool isDatePicked = false;
  bool isTimePicked = false;
  bool book = false;

  BookingRequest booking = BookingRequest(
    dateTime: null,
    guestCount: 2,
  );

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
          DateTime now = DateTime.now();
          DateTime firstDate = (now.hour >= snapshot.data!.closeTime.hour - 2)
              ? now.add(const Duration(days: 1))
              : now;
          booking.dateTime ??= firstDate;
          DateTime lastDate = firstDate.add(const Duration(days: 90));
          return Scaffold(
            appBar: AppBar(
              title: const Text("Book a table"),
              actions: const [
                BookingHelp(),
              ],
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
                if (book)
                  Expanded(
                    child: Center(
                      child: BookingResultView(
                        bookingRequest: booking,
                      ),
                    ),
                  )
                else
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 10),
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
                              initialDate: booking.dateTime,
                              firstDate: firstDate,
                              lastDate: lastDate,
                            );
                            if (pickedDate != null &&
                                pickedDate != booking.dateTime) {
                              setState(() {
                                booking.dateTime = pickedDate;
                                dateController.text = booking.dateTime
                                    .toString()
                                    .substring(0, 10);
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
                              final TimeOfDay? pickedTime =
                                  await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay(
                                          hour: booking.dateTime!.hour,
                                          minute: booking.dateTime!.minute),
                                      initialEntryMode:
                                          TimePickerEntryMode.input);
                              if (pickedTime != null) {
                                final DateTime currentTime = DateTime.now();
                                final DateTime selectedDateTime = DateTime(
                                    booking.dateTime!.year,
                                    booking.dateTime!.month,
                                    booking.dateTime!.day,
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
                                } else if (selectedDateTime.hour <
                                        snapshot.data!.openTime.hour ||
                                    selectedDateTime.hour >
                                        snapshot.data!.closeTime.hour - 2) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Selected time must be within the restaurant\'s working hours. And at least 2 hours from closing.'),
                                    ),
                                  );
                                } else {
                                  setState(() {
                                    booking.dateTime = selectedDateTime;
                                    isTimePicked = true;
                                    timeController.text =
                                        pickedTime.format(context);
                                  });
                                }
                              }
                            }),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Guests: ",
                                style: TextStyle(
                                  fontSize: 16,
                                )),
                            NumberPicker(
                              limit: 10,
                              value: booking.guestCount,
                              onChanged: (value) =>
                                  setState(() => booking.guestCount = value),
                            ),
                          ],
                        ),
                        FilledButton(
                          onPressed: () {
                            // Validate your booking here
                            if (!isDatePicked || !isTimePicked) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text('Please select a date and time.'),
                                ),
                              );
                              return;
                            } else {
                              setState(() {
                                book = true;
                              });
                            }
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
