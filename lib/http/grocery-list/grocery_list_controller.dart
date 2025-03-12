import 'dart:convert';

import 'package:grocery_flutter/http/auth/auth_controller.dart';
import 'package:grocery_flutter/http/social/request_result.dart';
import 'package:grocery_flutter/pages/grocery_lists/grocery_list_display.dart';
import 'package:grocery_flutter/pages/grocery_lists/grocery_list_item_display.dart';
import 'package:http/http.dart' as http;

class GroceryListController {
  static const String baseUrl = AuthController.baseUrl;
  final String jwt;

  GroceryListController({required this.jwt});

  Future<RequestResult<List<GroceryListDisplay>?>> getAllLists() async {
    try {
      final uri = Uri.parse("$baseUrl/api/grocery-list/get-all-lists");
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
                  .map((e) => GroceryListDisplay.fromJson(e))
                  .toList(),
        ),
        _ => RequestError(
          error:
              response.body.isEmpty
                  ? "Returned with status code ${response.statusCode}, without a body"
                  : "Returned with error code ${response.statusCode}: ${response.body}",
        ),
      };
    } catch (error) {
      return RequestError(error: error.toString());
    }
  }

  Future<RequestResult<List<GroceryListItemDisplay>?>> getListInfo(
    String listId,
  ) async {
    try {
      final uri = Uri.parse("$baseUrl/api/grocery-list/get-list/$listId");
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
                  .map((e) => GroceryListItemDisplay.fromJson(e))
                  .toList(),
        ),
        _ => RequestError(
          error:
              response.body.isEmpty
                  ? "Returned with status code ${response.statusCode}, without a body"
                  : "Returned with error code ${response.statusCode}: ${response.body}",
        ),
      };
    } catch (error) {
      return RequestError(error: error.toString());
    }
  }

  Future<RequestResult<void>> deleteList(String id) async {
    try {
      final uri = Uri.parse("$baseUrl/api/grocery-list/$id");
      final response = await http.delete(
        uri,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $jwt",
        },
      );
      return switch (response.statusCode) {
        200 => RequestSuccess(result: null),
        _ => RequestError(
          error:
              response.body.isEmpty
                  ? "Returned with status code ${response.statusCode}, without a body"
                  : "Returned with error code ${response.statusCode}: ${response.body}",
        ),
      };
    } catch (error) {
      return RequestError(error: error.toString());
    }
  }
}
