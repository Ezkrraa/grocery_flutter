import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grocery_flutter/http/social/invite_result.dart';
import 'package:grocery_flutter/http/social/social_controller.dart';
import 'package:grocery_flutter/http/social/user_info.dart';
import 'package:grocery_flutter/pages/person_invite/person_invite_args.dart';

class PersonInvitePage extends StatefulWidget {
  const PersonInvitePage({super.key});

  @override
  State<PersonInvitePage> createState() => _PersonInvitePageState();
}

class _PersonInvitePageState extends State<PersonInvitePage> {
  static String getDescription(Duration timeDelta) {
    if (timeDelta.inDays > 1) {
      return '${timeDelta.inDays - 1} days ago';
    } else if (timeDelta.inHours > 1) {
      return '${timeDelta.inHours} hours ago';
    } else if (timeDelta.inMinutes > 1) {
      return '${timeDelta.inMinutes} minutes ago';
    } else {
      return '${timeDelta.inSeconds} seconds ago';
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as PersonInviteArgs;
    var person = args.person;
    SocialController controller = SocialController(jwt: args.jwt);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("View user"),
      ),
      body: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Icon(Icons.person, size: 100),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    person.name,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),

                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      'Joined ${getDescription(DateTime.now().difference(person.joinedAt))}',
                    ),
                  ),
                ],
              ),
            ],
          ),
          person.isInGroup
              ? FilledButton(
                onPressed: null,
                style: Theme.of(context).filledButtonTheme.style,
                child: Text("Person is already in a group."),
              )
              : FilledButton(
                onPressed: () async {
                  var result = await controller.inviteUser(person.id);
                  if (result is SendInviteSuccess) {
                    setState(() {
                      person = UserInfo(
                        id: person.id,
                        name: person.name,
                        joinedAt: person.joinedAt,
                        isInGroup: true,
                      );
                    });
                  } else if (result is SendInviteError) {
                    Fluttertoast.showToast(msg: result.error);
                  }
                },
                child: Text("Invite"),
              ),
        ],
      ),
    );
  }
}
