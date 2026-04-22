import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://10.0.2.2:8000";
  // For Android emulator.
  // Change to your server IP when deploying.

  static Future<Map<String, dynamic>> post(
    String endpoint,
    Map<String, dynamic> data,
  ) async {
    final url = Uri.parse("$baseUrl$endpoint");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
      );

      return {"status": response.statusCode, "body": jsonDecode(response.body)};
    } catch (e) {
      return {
        "status": 500,
        "body": {"detail": "Connection error"},
      };
    }
  }

  static Future<Map<String, dynamic>> get(String endpoint, String token) async {
    final url = Uri.parse("$baseUrl$endpoint");

    try {
      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );

      return {"status": response.statusCode, "body": jsonDecode(response.body)};
    } catch (e) {
      return {
        "status": 500,
        "body": {"detail": "Connection error"},
      };
    }
  }
}
