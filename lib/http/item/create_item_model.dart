class CreateItemModel {
  final String categoryId;
  final String name;

  CreateItemModel({required this.categoryId, required this.name});

  String toJson() {
    return '{"CategoryId": "$categoryId", "Name": "$name"}';
  }
}
