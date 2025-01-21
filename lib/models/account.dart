class Account {
  final String username;
  final String email;

  Account({
    required this.username,
    required this.email,
  });

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      username: json['username'],
      email: json['email'],
    );
  }
}
