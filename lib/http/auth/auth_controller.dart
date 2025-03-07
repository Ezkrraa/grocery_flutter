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
}
