import 'dart:typed_data';
import 'package:grocery_flutter/pages/recipes/recipe_info.dart';

class RecipeDisplay {
  final RecipeInfo info;
  final Uint8List? imageBytes;

  const RecipeDisplay({required this.info, required this.imageBytes});
}
