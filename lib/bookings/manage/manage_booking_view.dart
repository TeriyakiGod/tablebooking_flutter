import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tablebooking_flutter/models/booking.dart';
import 'package:tablebooking_flutter/models/restaurant.dart';
import 'package:tablebooking_flutter/providers/booking_provider.dart';
import 'package:tablebooking_flutter/providers/restaurant_provider.dart';
import 'package:tablebooking_flutter/restaurant/restaurant_header.dart';

class ManageBookingView extends StatefulWidget {
  final Booking booking;

  const ManageBookingView({super.key, required this.booking});

  @override
  ManageBookingViewState createState() => ManageBookingViewState();
}

class ManageBookingViewState extends State<ManageBookingView> {
  late Future<Restaurant> _restaurantFuture;
  late DateTime _selectedDate;
  late TimeOfDay _selectedTime;
  late int _amountOfPeople;
  bool _isEditingPeople = false; // Track if "Number of People" is in edit mode
  bool _hasUnsavedChanges = false; // Track if there are unsaved changes

  @override
  void initState() {
    super.initState();
    _restaurantFuture = _fetchRestaurant();

    // Ensure the selected date is not in the past
    final DateTime now = DateTime.now();
    _selectedDate = widget.booking.date.isBefore(now) ? now : widget.booking.date;

    _selectedTime = TimeOfDay.fromDateTime(widget.booking.date);
    _amountOfPeople = widget.booking.amountOfPeople;
  }

  Future<Restaurant> _fetchRestaurant() async {
    final restaurantProvider =
        Provider.of<RestaurantProvider>(context, listen: false);
    return await restaurantProvider.fetchRestaurantById(widget.booking.restaurantId);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime firstDate = now; // Set the first selectable date to today
    final DateTime lastDate = DateTime(2101); // Set the last selectable date

    // Ensure the initialDate is not before the firstDate
    final DateTime initialDate = _selectedDate.isBefore(firstDate) ? firstDate : _selectedDate;

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _hasUnsavedChanges = true; // Mark changes as unsaved
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
        _hasUnsavedChanges = true; // Mark changes as unsaved
      });
    }
  }

  void _updateBooking() {
    final updatedBooking = Booking(
      id: widget.booking.id,
      appUserId: widget.booking.appUserId,
      restaurantId: widget.booking.restaurantId,
      date: DateTime(
        _selectedDate.year,
        _selectedDate.month,
        _selectedDate.day,
        _selectedTime.hour,
        _selectedTime.minute,
      ),
      durationInMinutes: widget.booking.durationInMinutes,
      amountOfPeople: _amountOfPeople,
    );

    // Call API to update booking
    BookingProvider().updateBooking(updatedBooking, context);
    setState(() {
      _hasUnsavedChanges = false; // Mark changes as saved
    });
  }

  Future<bool> _onWillPop() async {
    if (_hasUnsavedChanges) {
      final bool? shouldPop = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Unsaved Changes'),
          content: const Text('You have unsaved changes. Are you sure you want to leave?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Leave'),
            ),
          ],
        ),
      );
      return shouldPop ?? false;
    }
    return true;
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () async {
          if (await _onWillPop() && context.mounted) {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              Navigator.pushNamed(context, '/bookings');
            }
          }
        },
      ),
      title: const Text("Manage Booking"),
    );
  }

  Widget _buildBookingDetails() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Booking Details',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: const Text('Date'),
              subtitle: Text('${_selectedDate.toLocal()}'.split(' ')[0]),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () => _selectDate(context),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.access_time),
              title: const Text('Time'),
              subtitle: Text(_selectedTime.format(context)),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () => _selectTime(context),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.people),
              title: const Text('Number of People'),
              subtitle: Text('$_amountOfPeople'),
              trailing: _isEditingPeople
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () {
                            if (_amountOfPeople > 1) {
                              setState(() {
                                _amountOfPeople--;
                                _hasUnsavedChanges = true; // Mark changes as unsaved
                              });
                            }
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            setState(() {
                              _amountOfPeople++;
                              _hasUnsavedChanges = true; // Mark changes as unsaved
                            });
                          },
                        ),
                      ],
                    )
                  : IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        setState(() {
                          _isEditingPeople = true; // Enable edit mode
                        });
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: DEPRECATED CODE
    return WillPopScope(
      onWillPop: _onWillPop,
      child: FutureBuilder<Restaurant>(
        future: _restaurantFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final restaurant = snapshot.data!;
            return Scaffold(
              appBar: _buildAppBar(context),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    RestaurantHeader(
                      restaurant: restaurant,
                    ),
                    _buildBookingDetails(),
                  ],
                ),
              ),
                floatingActionButton: _hasUnsavedChanges
                  ? FloatingActionButton.extended(
                    onPressed: _updateBooking,
                    label: const Text("Update Booking"),
                    icon: const Icon(Icons.save),
                  )
                  : null,
            );
          } else if (snapshot.hasError) {
            return Scaffold(
              appBar: _buildAppBar(context),
              body: Center(
                child: Text("Error: ${snapshot.error}"),
              ),
            );
          }
          // By default, show a loading spinner.
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}