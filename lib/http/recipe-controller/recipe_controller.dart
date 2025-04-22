import 'dart:convert';
import 'dart:typed_data';

import 'package:grocery_flutter/http/auth/auth_controller.dart';
import 'package:grocery_flutter/http/social/request_result.dart';
import 'package:grocery_flutter/pages/recipes/recipe_info.dart';
import 'package:http/http.dart' as http;

class RecipeController {
  static const String baseUrl = AuthController.baseUrl;
  final String jwt;

  RecipeController({required this.jwt});

  Future<RequestResult<List<RecipeInfo>>> getAllRecipes() async {
    try {
      final uri = Uri.parse("$baseUrl/api/recipe");
      final response = await http.get(
        uri,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $jwt",
        },
      );
      return switch (response.statusCode) {
        200 => RequestSuccess(
          result:
              (jsonDecode(response.body) as List)
                  .map((e) => RecipeInfo.fromJson(e))
                  .toList(),
        ),
        _ => RequestError(error: response.body),
      };
    } catch (error) {
      return RequestError(error: error.toString());
    }
  }

  Future<RequestResult<Uint8List>> getPicture(String fileName) async {
    try {
      final uri = Uri.parse("$baseUrl/api/recipe/picture/$fileName");
      final response = await http.get(
        uri,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $jwt",
        },
      );
      return switch (response.statusCode) {
        200 => RequestSuccess(result: response.bodyBytes),
        _ => RequestError(error: response.body),
      };
    } catch (error) {
      return RequestError(error: error.toString());
    }
  }
}
