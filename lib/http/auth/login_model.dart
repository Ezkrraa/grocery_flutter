class LoginModel {
  LoginModel({required this.userName, required this.password});
  final String userName;
  final String password;
  String toJson() {
    return '{"userName": "$userName", "password": "$password"}';
  }
}
