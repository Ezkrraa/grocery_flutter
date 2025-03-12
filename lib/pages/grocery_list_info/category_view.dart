import 'package:flutter/material.dart';
import 'package:grocery_flutter/pages/grocery_list_info/item_card.dart';
import 'package:grocery_flutter/pages/grocery_lists/grocery_list_item_display.dart';

class CategoryView extends StatelessWidget {
  final MapEntry<String, List<GroceryListItemDisplay>> items;

  const CategoryView({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      spacing: 7,
      children:
          <Widget>[
                Text(
                  overflow: TextOverflow.clip,
                  softWrap: false,
                  style: Theme.of(context).textTheme.headlineSmall,
                  items.key,
                ),
              ]
              .followedBy(items.value.map((element) => ItemCard(info: element)))
              .toList(),
    );
  }
}
