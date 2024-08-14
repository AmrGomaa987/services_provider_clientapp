// home_category_model.dart
class HomeCategoryModel {
  String id;
  String name;
  String imageUrl;

  HomeCategoryModel({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  factory HomeCategoryModel.fromJson(Map<String, dynamic> json) {
    return HomeCategoryModel(
      id: json['_id'],
      name: json['name'],
      imageUrl: json['image'] ?? '',
    );
  }
}
