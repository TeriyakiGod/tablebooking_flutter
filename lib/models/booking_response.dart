class BookingResponse {
  final String id;
  final String tableId;
  final String customerId;
  final DateTime bookingTime;
  final bool isConfirmed;

  BookingResponse({
    required this.id,
    required this.tableId,
    required this.customerId,
    required this.bookingTime,
    required this.isConfirmed,
  });

  factory BookingResponse.fromJson(Map<String, dynamic> json) {
    return BookingResponse(
      id: json['id'],
      tableId: json['tableId'],
      customerId: json['customerId'],
      bookingTime: DateTime.parse(json['bookingTime']),
      isConfirmed: json['isConfirmed'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tableId': tableId,
      'customerId': customerId,
      'bookingTime': bookingTime.toIso8601String(),
      'isConfirmed': isConfirmed,
    };
  }
}
