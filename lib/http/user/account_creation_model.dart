class AccountCreationModel {
  final String userName;
  final String password;
  final String email;
  final List<int> pfp;

  AccountCreationModel({
    required this.userName,
    required this.password,
    required this.email,
    required this.pfp,
  });

  String toJson() {
    return '{"UserName": "$userName","Password": "$password","Email": "$email"}';
  }

  Iterable<MapEntry<String, String>> toStringMap() {
    return [
      MapEntry("UserName", userName),
      MapEntry("Password", password),
      MapEntry("Email", email),
    ];
  }
}
