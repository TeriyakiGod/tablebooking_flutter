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

  // Helper method to handle loading state and notifications
  void _startLoading() {
    _isLoading = true;
    notifyListeners();
  }

  void _stopLoading() {
    _isLoading = false;
    notifyListeners();
  }

  // Login user
  Future<void> login(String username, String password) async {
    _startLoading();

    try {
      final url = Uri.parse('${dotenv.env['API_URL']!}/User/login');

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
      } else if (response.statusCode == 401) {
        throw Exception('Invalid username or password');
      } else {
        throw Exception('Failed to login');
      }
    } catch (e) {
      rethrow; // Rethrow to let the caller handle the exception
    } finally {
      _stopLoading();
    }
  }

  // Fetch user information
  Future<void> fetchUserInfo() async {
    if (!isAuthenticated) return;

    _startLoading();

    try {
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
      } else {
        throw Exception('Failed to fetch user info');
      }
    } catch (e) {
      rethrow;
    } finally {
      _stopLoading();
    }
  }

  // Save token to secure storage
  Future<void> _saveToken(String token) async {
    await _secureStorage.write(key: 'auth_token', value: token);
  }

  // Auto-login user if token exists
  Future<void> autoLogin() async {
    _startLoading();

    try {
      final token = await _secureStorage.read(key: 'auth_token');
      if (token != null) {
        _token = token;
        await fetchUserInfo();
      }
    } catch (e) {
      rethrow;
    } finally {
      _stopLoading();
    }
  }

  // Logout user
  Future<void> logout() async {
    _startLoading();

    try {
      _token = null;
      _account = null;
      await _secureStorage.delete(key: 'auth_token');
    } catch (e) {
      rethrow;
    } finally {
      _stopLoading();
    }
  }

  // Register a new user
  Future<void> register(String username, String email, String password) async {
    _startLoading();

    try {
      final url = Uri.parse('${dotenv.env['API_URL']!}/User/register');
      final response = await http.post(
        url,
        body: json.encode({
          'username': username,
          'email': email,
          'password': password,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 201) {
        await login(username, password);
      } else {
        throw Exception('Failed to register');
      }
    } catch (e) {
      rethrow;
    } finally {
      _stopLoading();
    }
  }

  // TODO: Implement Password Reset
  void sendPasswordResetEmail(String email) {
    // Implementation for password reset
  }
}