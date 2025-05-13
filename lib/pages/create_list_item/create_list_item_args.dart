import 'package:grocery_flutter/pages/create_list/category_model.dart';

class CreateItemArgs {
  final String jwt;
  final String categoryId;
  final List<CategoryModel>? items;
  final int index;

  CreateItemArgs({
    required this.jwt,
    required this.categoryId,
    required this.items,
    this.index = 0,
  });
}
