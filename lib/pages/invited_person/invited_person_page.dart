//import 'package:flutter/material.dart';
//import 'package:flutter_secure_storage/flutter_secure_storage.dart';
//import 'package:grocery_flutter/http/social/invite.dart';
//import 'package:grocery_flutter/http/social/social_controller.dart';
//import 'package:grocery_flutter/pages/invited_person/invited_person_card.dart';
//
//class InvitedPersonPage extends StatefulWidget {
//  const InvitedPersonPage({super.key});
//
//  @override
//  State<InvitedPersonPage> createState() => _InvitedPersonPageState();
//}
//
//class _InvitedPersonPageState extends State<InvitedPersonPage> {
//  final searchController = TextEditingController();
//  // will NOT work if not initialized to null
//  late List<Invite>? invites = null;
//
//  @override
//  Widget build(BuildContext context) {
//    String jwt = ModalRoute.of(context)!.settings.arguments as String;
//    SocialController controller = SocialController(jwt: jwt);
//    if (invites == null) {
//      controller.getSentInvites().then(
//        (value) => setState(() {
//          invites = value;
//        }),
//        onError: (error) {
//          throw Exception(error);
//        },
//      );
//    }
//    return Scaffold(
//      appBar: AppBar(
//        actions: [
//          IconButton(
//            onPressed: () {
//              Navigator.of(context).pushNamed('/create-group', arguments: jwt);
//            },
//            icon: Icon(Icons.add),
//          ),
//          IconButton(
//            onPressed: () async {
//              await FlutterSecureStorage().delete(key: 'jwt');
//              Navigator.of(context).popAndPushNamed('/');
//            },
//            icon: Icon(Icons.logout),
//          ),
//        ],
//        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//        title: Text('Your invites'),
//      ),
//      body: Padding(
//        padding: EdgeInsets.all(10),
//        child: ListView(
//          children: [
//            Column(
//              children:
//                  invites == null
//                      ? <Widget>[Text("You don't have any invites")]
//                      : invites!
//                          .map(
//                            (e) => InvitedPersonCard(
//                              invite: e,
//                              onRetract: () => controller.retractInvite(e),
//                            ),
//                          )
//                          .toList(),
//            ),
//          ],
//        ),
//      ),
//    );
//  }
//}
//
