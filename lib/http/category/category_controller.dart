import 'package:grocery_flutter/http/auth/auth_controller.dart';
import 'package:grocery_flutter/http/social/request_result.dart';
import 'package:http/http.dart' as http;

class CategoryController {
  static const String baseUrl = AuthController.baseUrl;
  final String jwt;

  const CategoryController({required this.jwt});

  Future<RequestResult<void>> createCategory(String categoryName) async {
    try {
      final uri = Uri.parse("$baseUrl/api/category");
      final response = await http.post(
        uri,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $jwt",
        },
        body: '"$categoryName"',
      );
      return switch (response.statusCode) {
        200 => RequestSuccess(result: null),
        _ => RequestError(error: response.body),
      };
    } catch (error) {
      return RequestError(error: error.toString());
    }
  }
}
