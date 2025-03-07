import 'package:flutter/material.dart';
import 'package:grocery_flutter/http/social/user_info.dart';

class PersonCard extends StatelessWidget {
  final UserInfo userInfo;
  final GestureTapCallback onTap;

  const PersonCard({super.key, required this.userInfo, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(11)),
          ),
          color: Theme.of(context).buttonTheme.colorScheme!.onSecondary,
        ),
        child: Row(
          children: [Icon(Icons.person, size: 100), Text(userInfo.name)],
        ),
      ),
    );
  }
}
