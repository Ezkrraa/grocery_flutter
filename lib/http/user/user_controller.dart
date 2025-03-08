import 'package:grocery_flutter/http/user/account_creation_model.dart';
import 'package:grocery_flutter/http/user/account_creation_result.dart';
import 'package:http/http.dart' as http;

class UserController {
  static const String baseUrl = "http://192.168.1.111:7020";

  static Future<AccountCreationResult> createAccount(
    AccountCreationModel model,
  ) async {
    try {
      final uri = Uri.parse("$baseUrl/api/user/create");
      final response = await http.post(
        uri,
        headers: {"Content-Type": "application/json"},
        body: model.toJson(),
      );

      if (response.statusCode == 200) {
        return SuccessResult();
      }
      return FailureResult(reason: response.body);
    } catch (error) {
      return FailureResult(reason: error.toString());
    }
  }
}
