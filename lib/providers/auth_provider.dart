import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tablebooking_flutter/models/account.dart';

class AuthProvider with ChangeNotifier {
  String? _token;
  bool _isLoading = false;
  Account? _account;

  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  String? get token => _token;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _token != null;
  bool get isLoggedIn => isAuthenticated && _account != null;
  Account? get account => _account;

  Future<void> login(
      String username, String password) async {
    _isLoading = true;
    notifyListeners();

    final url = Uri.parse('${dotenv.env['API_URL']!}/User/login');
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'username': username,
          'password': password,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        _token = responseData['token'];
        await _saveToken(_token!);
        await fetchUserInfo();
      }
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchUserInfo() async {
    if (!isAuthenticated) return;

    final url = Uri.parse('${dotenv.env['API_URL']!}/User');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $_token',
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      _account = Account(
        username: responseData['username'],
        email: responseData['email'],
      );
      notifyListeners();
    } else {
      throw Exception('Failed to fetch user info');
    }
  }

  Future<void> _saveToken(String token) async {
    await _secureStorage.write(key: 'auth_token', value: token);
  }

  Future<void> autoLogin() async {
    final token = await _secureStorage.read(key: 'auth_token');
    if (token != null) {
      _token = token;
      await fetchUserInfo();
      notifyListeners();
    }
  }

  Future<void> logout() async {
    _token = null;
    _account = null;
    notifyListeners();
    await _secureStorage.delete(key: 'auth_token');
  }

  void sendPasswordResetEmail(String email) {}
}
