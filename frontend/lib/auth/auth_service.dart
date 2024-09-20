import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  final String baseUrl = 'https://your-api-url.com'; // Replace with your actual API URL
  final storage = FlutterSecureStorage();

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        await storage.write(key: 'token', value: data['token']);
        return data;
      } else {
        throw _handleHttpError(response);
      }
    } catch (e) {
      throw _handleError(e, 'Failed to login');
    }
  }

  Future<Map<String, dynamic>> signup(String name, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/signup'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'name': name, 'email': email, 'password': password}),
      );

      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        await storage.write(key: 'token', value: data['token']);
        return data;
      } else {
        throw _handleHttpError(response);
      }
    } catch (e) {
      throw _handleError(e, 'Failed to sign up');
    }
  }

  Future<void> forgotPassword(String email) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/forgot-password'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email}),
      );

      if (response.statusCode != 200) {
        throw _handleHttpError(response);
      }
    } catch (e) {
      throw _handleError(e, 'Failed to send password reset email');
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await storage.read(key: 'token');
    return token != null;
  }

  Future<void> logout() async {
    await storage.delete(key: 'token');
  }

  Future<String?> getToken() async {
    return await storage.read(key: 'token');
  }

  Exception _handleHttpError(http.Response response) {
    if (response.statusCode == 400) {
      final errorData = json.decode(response.body);
      return Exception(errorData['message'] ?? 'Bad request');
    } else if (response.statusCode == 401) {
      return Exception('Unauthorized');
    } else if (response.statusCode == 404) {
      return Exception('Not found');
    } else {
      return Exception('An error occurred: ${response.reasonPhrase}');
    }
  }

  Exception _handleError(dynamic e, String fallbackMessage) {
    if (e is Exception) {
      return e;
    } else {
      return Exception(fallbackMessage);
    }
  }
}