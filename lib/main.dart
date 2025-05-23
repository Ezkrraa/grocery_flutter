import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:grocery_flutter/pages/create_account_page.dart';
import 'package:grocery_flutter/pages/create_category/create_category_page.dart';
import 'package:grocery_flutter/pages/create_list_item/create_list_item_page.dart';
import 'package:grocery_flutter/pages/create_list/create_list_page.dart';
import 'package:grocery_flutter/pages/create_recipe/create_recipe_page.dart';
import 'package:grocery_flutter/pages/create_recipe_item_page/create_recipe_item_page.dart';
import 'package:grocery_flutter/pages/grocery_list_info/grocery_list_info_page.dart';
import 'package:grocery_flutter/pages/invite/received_invites_page.dart';
import 'package:grocery_flutter/pages/invite/send_invite_page.dart';
import 'package:grocery_flutter/pages/redirect/redirect_group_page.dart';
import 'package:grocery_flutter/pages/sent_invites_page/sent_invites_page.dart';
import 'package:grocery_flutter/pages/redirect/redirect_login_page.dart';
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen),
      ),
      // initialRoute: '/test',
      routes: {
        '/': (context) => const RedirectLoginPage(),
        '/redirect-group': (context) => const RedirectGroupPage(),
        '/login': (context) => const LoginPage(),
        '/create-account': (context) => const CreateAccountPage(),
        '/create-group': (context) => const CreateGroupPage(),
        '/home': (context) => const MyHomePage(),
        '/invite': (context) => const SendInvitePage(),
        '/invite-person': (context) => const PersonInvitePage(),
        '/received-invites': (context) => const ReceivedInvitesPage(),
        '/sent-invites': (context) => const SentInvitesPage(),
        '/settings': (context) => const SettingsPage(),
        '/view-grocery-list': (context) => const GroceryListInfoPage(),
        '/create-list': (context) => const CreateListPage(),
        '/create-list-item': (context) => const CreateItemPage(),
        '/create-recipe': (context) => const CreateRecipePage(),
        '/create-recipe-item': (context) => const CreateRecipeItemPage(),
        '/create-category': (context) => const CreateCategoryPage(),
        //
        // '/test': (context) => const TestImagePickerPage(),
      },
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: Colors.lightGreen,
        ),
      ),
    );
  }
}
