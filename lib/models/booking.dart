class Booking {
  final String id;
  final String appUserId;
  final String restaurantId;
  final DateTime date;
  final int durationInMinutes;
  final int amountOfPeople;

  Booking({
    required this.id,
    required this.appUserId,
    required this.restaurantId,
    required this.date,
    required this.durationInMinutes,
    required this.amountOfPeople,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'],
      appUserId: json['appUserId'],
      restaurantId: json['restaurantId'],
      date: DateTime.parse(json['date']),
      durationInMinutes: json['durationInMinutes'],
      amountOfPeople: json['amountOfPeople'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'appUserId': appUserId,
      'tableId': restaurantId,
      'date': date.toIso8601String(),
      'durationInMinutes': durationInMinutes,
      'amountOfPeople': amountOfPeople,
    };
  }
}