import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:grocery_flutter/http/social/group_info.dart';
import 'package:grocery_flutter/http/social/invite.dart';
import 'package:grocery_flutter/http/social/social_controller.dart';
import 'package:grocery_flutter/http/social/user_info.dart';
import 'package:grocery_flutter/pages/person_invite/person_invite_args.dart';
import 'package:grocery_flutter/pages/social/invite_card.dart';
import 'package:grocery_flutter/pages/social/person_card.dart';

class ViewInvitesPage extends StatefulWidget {
  const ViewInvitesPage({super.key});

  @override
  State<ViewInvitesPage> createState() => _ViewInvitesPageState();
}

class _ViewInvitesPageState extends State<ViewInvitesPage> {
  // will NOT work if not initialized to null
  late List<Invite>? invites = null;
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var jwt = ModalRoute.of(context)!.settings.arguments as String;
    SocialController controller = SocialController(jwt: jwt);
    if (invites == null) {
      controller.getMyInvites().then(
        (value) => setState(() {
          invites = value;
        }),
        onError: (error) {
          throw Exception(error);
        },
      );
    }
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/create-group', arguments: jwt);
            },
            icon: Icon(Icons.add),
          ),
          IconButton(
            onPressed: () async {
              await FlutterSecureStorage().delete(key: 'jwt');
              Navigator.of(context).popAndPushNamed('/');
            },
            icon: Icon(Icons.logout),
          ),
        ],
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Your invites'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            Column(
              children:
                  invites == null
                      ? [Text("You don't have any invites")]
                      : invites!
                          .map((e) => InviteCard(invite: e, onTap: () {}))
                          .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
