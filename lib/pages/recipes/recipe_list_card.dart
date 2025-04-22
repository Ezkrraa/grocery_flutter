import 'package:flutter/material.dart';
import 'package:grocery_flutter/pages/recipes/recipe_display.dart';

class RecipeListCard extends StatelessWidget {
  final RecipeDisplay info;
  final void Function()? onTap;

  const RecipeListCard({super.key, required this.info, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: ShapeDecoration(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(11)),
          ),
          color: Theme.of(context).buttonTheme.colorScheme!.onSecondary,
        ),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Row(
            spacing: 20,
            children: <Widget>[
              info.imageBytes == null
                  ? (const Icon(Icons.image, size: 90))
                  : ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.memory(
                      info.imageBytes!,
                      width: 90,
                      height: 90,
                    ),
                  ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    info.info.name,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(info.info.description),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
