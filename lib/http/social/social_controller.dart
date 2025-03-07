import 'dart:convert';

import 'package:grocery_flutter/http/social/group_info.dart';
import 'package:http/http.dart' as http;

class SocialController {
  static String baseUrl = "http://192.168.1.111:7020";

  static Future<GroupInfo?> getOwnGroup(String jwt) async {
    try {
      final uri = Uri.parse("$baseUrl/api/group");
      final response = await http.get(
        uri,
        headers: {
          "Content-Type": "application/json",
          'Accept': 'application/json',
          "Authorization": 'Bearer $jwt',
        },
      );
      if (response.statusCode == 200) {
        return GroupInfo.fromJson(jsonDecode(response.body));
      }
      return null;
    } catch (error) {
      return null;
    }
  }
}
