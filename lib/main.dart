import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:grocery_flutter/pages/create_account_page.dart';
import 'package:grocery_flutter/pages/invite/invite_page.dart';
import 'package:grocery_flutter/pages/load_redirect_page.dart';
import 'package:grocery_flutter/pages/login_page.dart';
import 'package:grocery_flutter/pages/my_home_page.dart';
import 'package:grocery_flutter/pages/person_invite/person_invite_page.dart';
import 'package:grocery_flutter/pages/settings_page.dart';
import 'package:grocery_flutter/pages/social/create_group_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const storage = FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grocery app',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoadRedirectPage(),
        '/login': (context) => const LoginPage(),
        '/create-account': (context) => const CreateAccountPage(),
        '/create-group': (context) => const CreateGroupPage(),
        '/home': (context) => const MyHomePage(),
        '/invite': (context) => const InvitePage(),
        '/invite-person': (context) => const PersonInvitePage(),
        '/settings': (context) => const SettingsPage(),
      },
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: Colors.orange,
        ),
      ),
    );
  }
}
