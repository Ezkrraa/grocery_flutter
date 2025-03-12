import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grocery_flutter/http/social/request_result.dart';
import 'package:grocery_flutter/http/social/social_controller.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    var jwt = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Settings'),
      ),
      body: Column(
        children: [
          Text("Jwt: $jwt"),
          FilledButton(
            onPressed: () async {
              if (mounted) {
                var controller = SocialController(jwt: jwt);
                var result = await controller.leaveGroup();
                if (result is RequestSuccess) {
                  Fluttertoast.showToast(msg: "Left your group");
                  if (context.mounted) {
                    Navigator.of(context).pop();
                  }
                } else if (result is RequestError) {
                  Fluttertoast.showToast(
                    msg: "Failed because '${result.error}'",
                  );
                }
              }
            },
            child: const Text('Leave group'),
          ),
        ],
      ),
    );
  }
}
