import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grocery_flutter/http/social/social_controller.dart';
import 'package:grocery_flutter/http/social/user_info.dart';
import 'package:grocery_flutter/pages/social/social_group_page.dart';
import 'package:grocery_flutter/pages/invite/received_invites_page.dart';

class SocialHomePage extends StatefulWidget {
  const SocialHomePage({super.key});

  @override
  State<SocialHomePage> createState() => _SocialHomePageState();
}

class _SocialHomePageState extends State<SocialHomePage> {
  _SocialHomePageState();

  int status = 0;
  @override
  Widget build(BuildContext context) {
    if (status == 0) {
      return Center(child: CircularProgressIndicator());
    } else if (status == 1) {
      return SocialGroupPage();
    } else {
      return ReceivedInvitesPage();
    }
  }

  @override
  void initState() {
    super.initState();
    checkStatus();
  }

  Future<void> checkStatus() async {
    var jwt = await FlutterSecureStorage().read(key: 'jwt');
    if (jwt == null) {
      Fluttertoast.showToast(msg: "JWT from storage was null");
    }
    var controller = SocialController(jwt: jwt!);
    UserInfo? info = await controller.getMyInfo();
    if (info == null) {
      Fluttertoast.showToast(msg: 'Userinfo was null, tell the dev :(');
    } else {
      setState(() {
        status = info.isInGroup ? 1 : 2;
      });
    }
  }
}
