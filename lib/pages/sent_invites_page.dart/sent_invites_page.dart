import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grocery_flutter/http/social/invite.dart';
import 'package:grocery_flutter/http/social/request_result.dart';
import 'package:grocery_flutter/http/social/social_controller.dart';
import 'package:grocery_flutter/pages/invited_person/invited_person_card.dart';
import 'package:grocery_flutter/pages/sent_invites_page.dart/sent_invites_args.dart';

class SentInvitesPage extends StatefulWidget {
  const SentInvitesPage({super.key});

  @override
  State<SentInvitesPage> createState() => _SentInvitesPageState();
}

class _SentInvitesPageState extends State<SentInvitesPage> {
  // will NOT work if not initialized to null
  late List<Invite>? invites = null;
  final searchController = TextEditingController();

  refresh(SocialController controller) {
    controller.getSentInvites().then(
      (value) => setState(() {
        invites = value;
      }),
      onError: (error) {
        throw Exception(error);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as SentInvitesArgs;
    SocialController controller = SocialController(jwt: args.jwt);
    if (invites == null) {
      refresh(controller);
    }
    return Scaffold(
      appBar: AppBar(
        actions: [
          !args.isInGroup
              ? IconButton(
                onPressed: () {
                  Navigator.of(
                    context,
                  ).pushNamed('/create-group', arguments: args.jwt);
                },
                icon: Icon(Icons.add),
              )
              : SizedBox.shrink(),

          IconButton(
            onPressed: () async {
              await FlutterSecureStorage().delete(key: 'jwt');
              if (context.mounted) {
                Navigator.of(context).popAndPushNamed('/');
              }
            },
            icon: Icon(Icons.logout),
          ),
        ],
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Sent invites'),
      ),
      body: RefreshIndicator(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: [
              Column(
                spacing: 10,
                children:
                    invites == null
                        ? <Widget>[
                          Center(
                            child: Center(
                              child: Column(
                                children: [
                                  CircularProgressIndicator(),
                                  Text("Fetching response"),
                                ],
                              ),
                            ),
                          ),
                        ]
                        : (invites!.isEmpty
                            ? const <Widget>[
                              Center(
                                child: Text("You haven't sent any invites yet"),
                              ),
                            ]
                            : invites!
                                .map(
                                  (e) => InvitedPersonCard(
                                    invite: e,
                                    onRetract: () async {
                                      var result = await controller
                                          .retractInvite(e);
                                      if (result is RequestSuccess) {
                                        setState(() {
                                          invites!.remove(e);
                                        });
                                      } else if (result is RequestError) {
                                        Fluttertoast.showToast(
                                          msg:
                                              "Error type: ${result.errorType()}, Error: ${result.error}",
                                        );
                                      } else {
                                        Fluttertoast.showToast(
                                          msg:
                                              "Something unknown went wrong revoking this request",
                                        );
                                      }
                                    },
                                  ),
                                )
                                .toList()),
              ),
            ],
          ),
        ),
        onRefresh: () {
          return Future(() => refresh(controller));
        },
      ),
    );
  }
}
