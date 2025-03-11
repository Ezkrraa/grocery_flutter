import 'package:flutter/material.dart';
import 'package:grocery_flutter/pages/grocery_lists/grocery_list_item_display.dart';

class ItemCard extends StatelessWidget {
  final GroceryListItemDisplay info;
  const ItemCard({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(11)),
        ),
        color: Theme.of(context).buttonTheme.colorScheme!.onSecondary,
      ),
      child: Row(
        spacing: 5,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Icon(Icons.circle, size: 5),
          Text(info.name + (info.quantity > 1 ? '(${info.quantity})' : '')),
        ],
      ),
    );
  }
}
