// category_controller.dart
import 'package:clientphase/models/category_model.dart';
import 'package:clientphase/models/home_category_model.dart';
import 'package:dio/dio.dart';

class CategoryController {
  final Dio dio = Dio();
    var categories = Category(id: "", name: "", image: "", options: []);

  final String baseUrl = 'https://homo.onrender.com/api/v1';

  Future<List<HomeCategoryModel>> fetchCategories() async {
    try {
      final response =
          await dio.get('$baseUrl/categories?limit=12&fields=name,image,id');

      if (response.statusCode == 200) {
        List<HomeCategoryModel> categories =
            (response.data['data']['docs'] as List)
                .map((json) => HomeCategoryModel.fromJson(json))
                .toList();
        return categories;
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      throw Exception('Failed to load categories: $e');
    }
  }
}
