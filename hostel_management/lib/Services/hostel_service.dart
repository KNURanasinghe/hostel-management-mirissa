import 'dart:convert';

import 'package:http/http.dart' as http;

class HostelService {
  static const String baseUrl = "http://69.10.53.116:5000/api";

  static Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      final error = jsonDecode(response.body);
      throw Exception(error['error'] ?? 'Unknown error');
    }
  }

  static Future<Map<String, dynamic>> getHostels() async {
    final url = Uri.parse('$baseUrl/hostels');
    final response = await http.get(url);
    print('hostel response $response');
    return _handleResponse(response);
  }
}
