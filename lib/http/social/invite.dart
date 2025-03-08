class Invite {
  Invite({
    required this.groupId,
    required this.userId,
    required this.groupName,
    required this.createdAt,
    required this.expiresAt,
    required this.groupMemberCount,
  });

  final String groupId;
  final String userId;
  final String groupName;
  final DateTime createdAt;
  final DateTime expiresAt;
  final int groupMemberCount;

  factory Invite.fromJson(Map<String, dynamic> json) {
    return Invite(
      groupId: json['groupId'],
      userId: json['userId'],
      groupName: json['groupName'],
      createdAt: DateTime.parse(json['createdAt']),
      expiresAt: DateTime.parse(json['expiresAt']),
      groupMemberCount: json['groupMemberCount'],
    );
  }
}
