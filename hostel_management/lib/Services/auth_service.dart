import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl =
      "http://69.10.53.116:5000/api"; // Change to your server URL

  // Register
  static Future<Map<String, dynamic>> register(
    String name,
    String email,
    String password,
    String? deviceId,
  ) async {
    final url = Uri.parse('$baseUrl/auth/register');
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "name": name,
        "email": email,
        "password": password,
        "deviceId": deviceId,
      }),
    );
    print('Response body: ${response.body}');
    return _handleResponse(response);
  }

  // Login
  static Future<Map<String, dynamic>> login(
    String email,
    String password,
  ) async {
    final url = Uri.parse('$baseUrl/auth/login');
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );
    print('Response body log: ${response.body}');
    return _handleResponse(response);
  }

  //get user profile
  static Future<Map<String, dynamic>> getUserProfile(String userId) async {
    final url = Uri.parse('$baseUrl/auth/profile');
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"userId": userId}),
    );
    print('Response body profile: ${response.body}');
    return _handleResponse(response);
  }

  // Forgot Password (Send 4-digit OTP)
  static Future<Map<String, dynamic>> forgotPassword(String email) async {
    final url = Uri.parse('$baseUrl/auth/request-reset');
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email}),
    );
    print('Response body forgot: ${response.body}');
    return _handleResponse(response);
  }

  // Verify OTP (4-digit)
  static Future<Map<String, dynamic>> verifyOtp(
    String userId,
    String otp,
  ) async {
    final url = Uri.parse('$baseUrl/auth/verify-otp');
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"userId": userId, "otp": otp}),
    );
    print('Response body verify OTP: ${response.body}');
    return _handleResponse(response);
  }

  // Make sure this method exists in your auth_service.dart:
  static Future<Map<String, dynamic>> resetPasswordWithOtp(
    String userId,
    String otp,
    String newPassword,
  ) async {
    final url = Uri.parse(
      '$baseUrl/auth/reset-password-otp',
    ); // Note: not /reset-password
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "userId": userId,
        "otp": otp,
        "newPassword": newPassword,
      }),
    );
    print('Response body reset password: ${response.body}');
    return _handleResponse(response);
  }

  // Legacy Reset Password (keep for backward compatibility)
  static Future<Map<String, dynamic>> resetPassword(
    String email,
    String newPassword,
  ) async {
    final url = Uri.parse('$baseUrl/auth/reset-password');
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "newPassword": newPassword}),
    );
    return _handleResponse(response);
  }

  // Private method to handle response
  static Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      final error = jsonDecode(response.body);
      throw Exception(error['error'] ?? 'Unknown error');
    }
  }
}
