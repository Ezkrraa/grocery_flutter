import 'package:grocery_flutter/http/auth/auth_controller.dart';
import 'package:grocery_flutter/http/user/account_creation_model.dart';
import 'package:grocery_flutter/http/user/account_creation_result.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:uuid/uuid.dart';

class UserController {
  static const String baseUrl = AuthController.baseUrl;

  static Future<AccountCreationResult> createAccount(
    AccountCreationModel model,
  ) async {
    try {
      final uri = Uri.parse("$baseUrl/api/auth/create");
      var request = http.MultipartRequest("POST", uri);
      request.fields.addEntries(model.toStringMap());
      request.files.add(
        http.MultipartFile.fromBytes(
          "ProfilePicture",
          model.pfp,
          contentType: MediaType.parse("image/jpeg"),
          filename: "ProfilePicture-${model.userName}-${Uuid().v4()}.jpeg",
        ),
      );
      final response = await request.send();

      if (response.statusCode == 200) {
        return SuccessResult();
      }
      final reason = await response.stream.bytesToString();
      return FailureResult(reason: '${response.statusCode} with error $reason');
    } catch (error) {
      return FailureResult(reason: error.toString());
    }
  }
}
