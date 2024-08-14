import 'package:clientphase/services/api/api.dart';
import 'package:dio/dio.dart';

class CategoryApi {
  final Dio _dio = DioClient().dio;

  Future<Response> getCategoriesHome() async {
    try {
      return await _dio.get('/v1/categories', queryParameters: {"limit": 8});
    } catch (e) {
      throw Exception('Failed to fetch home categories $e');
    }
  }

  Future<Response> getAllCategories() async {
    try {
      return await _dio.get('/v1/categories');
    } catch (e) {
      throw Exception('Failed to fetch all categories');
    }
  }

  Future<Response> getCategory({required String id}) async {
    try {
      return await _dio.get('/v1/categories/$id');
    } catch (e) {
      throw Exception('Failed to fetch category with id: $id');
    }
  }
}
