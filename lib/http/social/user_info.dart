class UserInfo {
  UserInfo({required this.id, required this.name});

  final String id;
  final String name;

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(id: json['id'] as String, name: json['name'] as String);
  }
}
