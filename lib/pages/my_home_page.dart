import 'package:flutter/material.dart';
import 'package:grocery_flutter/pages/grocery_lists/grocery_lists_page.dart';
import 'package:grocery_flutter/pages/recipes/recipes_page.dart';
import 'package:grocery_flutter/pages/social/social_home_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.list_alt),
            label: 'Grocery lists',
          ),
          NavigationDestination(icon: Icon(Icons.book), label: 'Recipes'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Social'),
        ],
        onDestinationSelected: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
      body: switch (currentIndex) {
        0 => const ViewGroceryListsPage(),
        1 => const RecipesPage(),
        2 => const SocialHomePage(),
        _ => const Align(
          alignment: Alignment.center,
          child: Text('What happen??? :<<'),
        ),
      },
    );
  }
}
