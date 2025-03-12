import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grocery_flutter/pages/create_list/category_model.dart';

class CategorySelectCard extends StatelessWidget {
  final CategoryModel category;
  final void Function()? onDecrement;
  final void Function()? onIncrement;
  const CategorySelectCard({
    super.key,
    required this.category,
    required this.onDecrement,
    required this.onIncrement,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(11)),
          ),
          color: Theme.of(context).buttonTheme.colorScheme!.onSecondary,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              category.name,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              spacing: 3,
              children:
                  category.items.map((item) {
                    return Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        IconButton(
                          style: ButtonStyle(),

                          onPressed: onDecrement,
                          icon: Icon(Icons.remove),
                        ),
                        Text(item.quantity.toString()),
                        IconButton(
                          onPressed: () {
                            Fluttertoast.showToast(
                              msg: item.quantity.toString(),
                            );
                          },
                          icon: Icon(Icons.add),
                        ),
                        Text(item.name),
                      ],
                    );
                  }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
