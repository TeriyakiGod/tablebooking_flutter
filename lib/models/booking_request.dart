class BookingRequest {
  DateTime? dateTime;
  int guestCount;

  BookingRequest({
    required this.dateTime,
    required this.guestCount,
  });

  Map<String, dynamic> toJson() {
    return {
      'dateTime': dateTime!.toIso8601String(),
      'guestCount': guestCount,
    };
  }
}
