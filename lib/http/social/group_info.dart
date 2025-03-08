import 'package:grocery_flutter/http/social/user_info.dart';

class GroupInfo {
  GroupInfo({
    required this.id,
    required this.users,
    required this.createdAt,
    required this.owner,
  });

  final String id;
  final List<UserInfo> users;
  final DateTime createdAt;
  final String owner;

  factory GroupInfo.fromJson(Map<String, dynamic> json) {
    List users = json['members'] as List;
    return GroupInfo(
      id: json['id'] as String,
      users:
          users.map((userInfoJson) => UserInfo.fromJson(userInfoJson)).toList(),
      createdAt: DateTime.parse(json['createdAt']),
      owner: json['owner'] as String,
    );
  }
}
