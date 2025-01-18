class Booking {
  final String id;
  final String appUserId;
  final String tableId;
  final DateTime date;
  final int durationInMinutes;
  final int amountOfPeople;

  Booking({
    required this.id,
    required this.appUserId,
    required this.tableId,
    required this.date,
    required this.durationInMinutes,
    required this.amountOfPeople,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'],
      appUserId: json['appUserId'],
      tableId: json['tableId'],
      date: DateTime.parse(json['date']),
      durationInMinutes: json['durationInMinutes'],
      amountOfPeople: json['amountOfPeople'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'appUserId': appUserId,
      'tableId': tableId,
      'date': date.toIso8601String(),
      'durationInMinutes': durationInMinutes,
      'amountOfPeople': amountOfPeople,
    };
  }

  static List<Booking> example() {
    return [
      Booking(
        id: '019479e2-0380-7cc0-acce-7343acde730a',
        appUserId: '019478e9-605a-7c24-8fbd-4ca0618ca8c2',
        tableId: '123e1a20-6801-4a5e-a327-ecc5cb2bd906',
        date: DateTime.parse('2025-01-18T14:47:08.475Z'),
        durationInMinutes: 120,
        amountOfPeople: 1,
      ),
    ];
  }
}