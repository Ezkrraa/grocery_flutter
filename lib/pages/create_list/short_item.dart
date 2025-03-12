class ShortItem {
  final String id;
  final String name;
  int quantity = 0;

  ShortItem({required this.id, required this.name});

  factory ShortItem.fromJson(Map<String, dynamic> json) {
    return ShortItem(id: json['id'], name: json['name']);
  }
}
