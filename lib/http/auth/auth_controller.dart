import 'package:grocery_flutter/http/auth/login_model.dart';
import 'package:http/http.dart' as http;

class AuthController {
  static const String baseUrl = "http://192.168.1.111:7020";

  static Future<String?> login(LoginModel model) async {
    try {
      final uri = Uri.parse("$baseUrl/api/auth/login");
      final response = await http.post(
        uri,
        headers: {"Content-Type": "application/json"},
        body: model.toJson(),
      );

      if (response.statusCode == 200) {
        return response.body;
      }
      return 'Server returned a status ${response.statusCode.toRadixString(10)}';
    } catch (error) {
      return error.toString();
    }
  }

  static Future<bool> isValidToken(String jwt) async {
    try {
      final uri = Uri.parse("$baseUrl/api/auth/check-token");
      final response = await http.get(
        uri,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $jwt",
        },
      );
      return response.statusCode == 200;
    } catch (error) {
      return false;
    }
  }
}
