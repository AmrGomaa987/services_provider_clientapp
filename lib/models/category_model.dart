class Category {
  final String id;
  final String name;
  final String image;
  final List<dynamic> options;

  Category({
    required this.id,
    required this.name,
    required this.image,
    required this.options,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['_id'],
      name: json['name'],
      image: json['image'],
      options: json['options'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      '_id': id,
      'name': name,
      'image': image,
      'options': options,
    };
    return data;
  }
}
