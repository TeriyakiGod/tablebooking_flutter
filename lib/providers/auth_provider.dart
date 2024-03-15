import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tablebooking_flutter/models/account.dart';

class AuthProvider with ChangeNotifier {
  final storage = FlutterSecureStorage();
  DateTime? _expiryDate;

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    //final url = 'https://www.your-backend.com/api/user/$urlSegment';
    try {
      // final response = await http.post(
      //   Uri.parse(url),
      //   body: json.encode(
      //     {
      //       'email': email,
      //       'password': password,
      //       'returnSecureToken': true,
      //     },
      //   ),
      // );
      // final responseData = json.decode(response.body);
      // if (responseData['error'] != null) {
      //   throw Exception(responseData['error']['message']);
      // }
      // await storage.write(key: "jwt", value: responseData['idToken']);
      // _expiryDate = DateTime.now().add(
      //   Duration(
      //     seconds: int.parse(
      //       responseData['expiresIn'],
      //     ),
      //   ),
      // );
      await storage.write(key: "jwt", value: "dummyToken");
      _expiryDate = DateTime.now().add(
        const Duration(
          seconds: 3600,
        ),
      );
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> signUp(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> logIn(String email, String password) async {
    return _authenticate(email, password, 'logIn');
  }

  Future<bool> get isAuthenticated async {
    return (await storage.read(key: "jwt")) != null &&
        _expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now());
  }

  Future<String?> get token async {
    if (_expiryDate != null && _expiryDate!.isAfter(DateTime.now())) {
      return await storage.read(key: "jwt");
    }
    return null;
  }

  Account get getUserInfo {
    return Account(
      id: "1",
      name: "John Doe",
      email: "email@email.com",
    );
  }

  void logOut() {
    storage.delete(key: "jwt");
    _expiryDate = null;
    notifyListeners();
  }
}
