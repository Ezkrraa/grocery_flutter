import 'package:flutter/material.dart';
import 'package:grocery_flutter/http/social/invite.dart';
import 'package:grocery_flutter/http/social/user_info.dart';

class InviteCard extends StatelessWidget {
  final Invite invite;
  final GestureTapCallback onTap;

  const InviteCard({super.key, required this.invite, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(11)),
          ),
          color: Theme.of(context).buttonTheme.colorScheme!.onSecondary,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  invite.groupName,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),

                Align(
                  alignment: Alignment.bottomRight,
                  child: Text('Invited at ${invite.createdAt}'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
