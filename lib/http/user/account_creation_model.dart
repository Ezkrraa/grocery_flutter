class AccountCreationModel {
  AccountCreationModel({
    required this.userName,
    required this.password,
    required this.email,
  });
  final String userName;
  final String password;
  final String email;
  String toJson() {
    return '{"UserName": "$userName","Password": "$password","Email": "$email"}';
  }
}
