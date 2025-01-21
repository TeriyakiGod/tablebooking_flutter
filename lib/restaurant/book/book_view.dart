import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tablebooking_flutter/restaurant/book/book_help.dart';
import 'package:tablebooking_flutter/models/booking_request.dart';
import 'package:tablebooking_flutter/models/restaurant.dart';
import 'package:tablebooking_flutter/restaurant/book/number_picker.dart';
import 'package:tablebooking_flutter/search/list/restaurant_info.dart';
import 'package:tablebooking_flutter/restaurant/book/book_result_view.dart';
import 'package:intl/intl.dart';

import '../../providers/restaurant_provider.dart';

class BookView extends StatefulWidget {
  final Restaurant? restaurant;
  final String? restaurantId;

  BookView({super.key, this.restaurant, this.restaurantId}) {
    if (restaurant == null && restaurantId == null) {
      throw ArgumentError(
          'You must provide either a restaurant or a restaurantId');
    }
  }

  @override
  BookViewState createState() => BookViewState();
}

class BookViewState extends State<BookView> {
  late Future<Restaurant> restaurant;
  bool isDatePicked = false;
  bool isTimePicked = false;
  bool isBookingCompleted = false;

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
    final restaurantProvider =
        Provider.of<RestaurantProvider>(context, listen: false);
    return await restaurantProvider.fetchRestaurantById(widget.restaurantId!);
  }

  Widget buildRestaurantInfo(Restaurant restaurant) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.network(
          restaurant.primaryImageURL,
          fit: BoxFit.cover,
          width: double.infinity,
          height: 200,
        ),
        RestaurantInfo(restaurant: restaurant),
      ],
    );
  }

  Widget buildDateSelector(
      BuildContext context, DateTime firstDate, DateTime lastDate) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              DateFormat('dd/MM/yyyy').format(booking.dateTime!),
              style: const TextStyle(fontSize: 16),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () async {
              final DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: booking.dateTime ?? firstDate,
                firstDate: firstDate,
                lastDate: lastDate,
              );
              if (pickedDate != null) {
                setState(() {
                  booking.dateTime = pickedDate;
                  isDatePicked = true;
                });
              }
            },
          ),
        ],
      ),
    );
  }

  Widget buildTimeSelector(Restaurant restaurant) {
    final DateTime now = DateTime.now();
    final DateTime startTime = DateTime(
      booking.dateTime!.year,
      booking.dateTime!.month,
      booking.dateTime!.day,
      restaurant.openTime.hour,
      restaurant.openTime.minute,
    );
    final DateTime endTime = DateTime(
      booking.dateTime!.year,
      booking.dateTime!.month,
      booking.dateTime!.day,
      restaurant.closeTime.hour - 2,
      restaurant.closeTime.minute,
    );

    // Define disabled times
    final List<DateTime> disabledTimes = [
      startTime
          .add(const Duration(minutes: 30)), // Example: Disable the second slot
      startTime
          .add(const Duration(minutes: 90)), // Example: Disable the fourth slot
    ];

    List<DateTime> generateTimeSlots() {
      List<DateTime> slots = [];
      DateTime slot = startTime;
      while (slot.isBefore(endTime)) {
        slots.add(slot);
        slot = slot.add(const Duration(minutes: 30));
      }
      return slots;
    }

    final timeSlots = generateTimeSlots();

    return SizedBox(
      height: 50,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        scrollDirection: Axis.horizontal,
        itemCount: timeSlots.length,
        itemBuilder: (context, index) {
          final slot = timeSlots[index];
          final bool isDisabled =
              slot.isBefore(now.add(const Duration(hours: 2))) ||
                  disabledTimes.contains(slot);
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: ChoiceChip(
              label: Text(
                "${slot.hour.toString().padLeft(2, '0')}:${slot.minute.toString().padLeft(2, '0')}",
              ),
              selected: booking.dateTime?.hour == slot.hour &&
                  booking.dateTime?.minute == slot.minute,
              onSelected: isDisabled
                  ? null
                  : (selected) {
                      if (selected) {
                        setState(() {
                          booking.dateTime = slot;
                          isTimePicked = true;
                        });
                      }
                    },
              selectedColor: Theme.of(context).primaryColorDark,
              disabledColor: Theme.of(context).disabledColor,
            ),
          );
        },
      ),
    );
  }

  Widget buildGuestSelector() {
    return Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Guests:", style: TextStyle(fontSize: 16)),
            NumberPicker(
              limit: 10,
              value: booking.guestCount,
              onChanged: (value) => setState(() => booking.guestCount = value),
            ),
          ],
        ));
  }

  Widget buildBookingForm(BuildContext context, Restaurant restaurant,
      DateTime firstDate, DateTime lastDate) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 10),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Select date and time:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        buildDateSelector(context, firstDate, lastDate),
        buildTimeSelector(restaurant),
        buildGuestSelector(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: SizedBox(
            child: ElevatedButton(
              onPressed: handleBooking,
              child: const Text("Book a table"),
            ),
          ),
        ),
      ],
    );
  }

  void handleBooking() {
    if (!isDatePicked || !isTimePicked) {
      showSnackBar(context, 'Please select both date and time.');
    } else {
      setState(() {
        isBookingCompleted = true;
      });
    }
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Restaurant>(
      future: restaurant,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (snapshot.hasData) {
          final restaurant = snapshot.data!;
          final now = DateTime.now();
          final firstDate = now.hour >= restaurant.closeTime.hour - 2
              ? now.add(const Duration(days: 1))
              : now;
          final lastDate = firstDate.add(const Duration(days: 90));
          booking.dateTime ??= firstDate;

          return Scaffold(
            appBar: AppBar(
              title: const Text("Book a table"),
              actions: const [BookingHelp()],
            ),
            body: ListView(
              children: [
                buildRestaurantInfo(restaurant),
                const Divider(),
                if (isBookingCompleted)
                  Center(
                      child: BookResultView(
                    bookingRequest: booking,
                    restaurantId: restaurant.id,
                  ))
                else
                  buildBookingForm(context, restaurant, firstDate, lastDate),
              ],
            ),
          );
        }

        return const Center(child: Text('Unexpected state.'));
      },
    );
  }
}
