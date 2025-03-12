import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grocery_flutter/http/social/invite.dart';
import 'package:grocery_flutter/http/social/request_result.dart';
import 'package:grocery_flutter/http/social/social_controller.dart';
import 'package:grocery_flutter/pages/invite/invite_card.dart';

class ReceivedInvitesPage extends StatefulWidget {
  const ReceivedInvitesPage({super.key});

  @override
  State<ReceivedInvitesPage> createState() => _ReceivedInvitesPageState();
}

class _ReceivedInvitesPageState extends State<ReceivedInvitesPage> {
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
              if (context.mounted) Navigator.of(context).popAndPushNamed('/');
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
                          .map(
                            (e) => InviteCard(
                              invite: e,
                              onAccept: () async {
                                var result = await controller.acceptInvite(e);
                                if (result is RequestSuccess) {
                                  Fluttertoast.showToast(msg: 'Succes :D');
                                } else if (result is RequestError) {
                                  Fluttertoast.showToast(
                                    msg:
                                        'Error type: ${result.errorType()}, Error: ${result.error}',
                                  );
                                } else {
                                  Fluttertoast.showToast(
                                    msg: 'Something went horribly wrong here',
                                  );
                                  throw Exception("Impossible state occurred");
                                }

                                return;
                              },
                              onReject: () async {
                                var result = await controller.rejectInvite(e);
                                if (result is RequestSuccess) {
                                  Fluttertoast.showToast(msg: 'Succes :D');
                                } else if (result is RequestError) {
                                  Fluttertoast.showToast(
                                    msg:
                                        'Error type: ${result.errorType()}, Error: ${result.error}',
                                  );
                                } else {
                                  Fluttertoast.showToast(
                                    msg: 'Something went horribly wrong here',
                                  );
                                  throw Exception("Impossible state occurred");
                                }

                                return;
                              },
                            ),
                          )
                          .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
