class UserInfo {
  UserInfo({
    required this.id,
    required this.name,
    required this.joinedAt,
    required this.isInGroup,
  });

  final String id;
  final String name;
  final DateTime joinedAt;
  final bool isInGroup;

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      id: json['id'] as String,
      name: json['name'] as String,
      joinedAt: DateTime.parse(json['joinedAt']),
      isInGroup: json['isInGroup'] as bool,
    );
  }
}
