import 'package:grocery_flutter/pages/grocery_lists/grocery_list_display.dart';

class GroceryListInfoArgs {
  GroceryListInfoArgs({required this.list, required this.jwt});

  final GroceryListDisplay list;
  final String jwt;
}
