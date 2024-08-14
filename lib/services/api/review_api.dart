import 'package:clientphase/models/review_model.dart';
import 'package:clientphase/services/api/api.dart';
import 'package:dio/dio.dart';

class ReviewApi {
  final Dio _dio = DioClient().dio;


  Future<Response> createReview(

      Map<String, Object> data, 
      {required String serviceId,
      required String ratings,
      String? title}) async {

    Map<String, dynamic> data = {
      'service': serviceId,
      'ratings': ratings,
    };
    if (title != null && title.isNotEmpty) data['title'] = title;

    try {
      print("data1 $data");

      final res = await _dio.post("/v1/review", data: data);

      print("data2 $res.data");
      return res;
    } catch (e) {
      throw Exception(
          "Failed to create review for service with id: $serviceId | error: $e");
    }
  }
  Future<List<Review>> getServiceReview( String serviceId) async {
    try {
      final response = await _dio.get('/v1/review?service=$serviceId');
      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData != null && responseData["data"] != null && responseData["data"]["docs"] is List) {
          final List<dynamic> data = responseData["data"]["docs"];
          return data.map((json) => Review.fromJson(json)).toList();
        } else {
          throw Exception('Unexpected response format or data is null: $responseData');
        }
      } else {
        throw Exception('Error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception("Failed to fetch services by category ID: $e");
    }
  }


////////////////////////////////
/*Future<Response> getServiceReview({required String serviceId}) async {
    try {
      return await _dio.get('/v1/review?product=$serviceId');
    } catch (e) {
      throw Exception(
          "Failed to fetch review for service with id: $serviceId | error: $e");
    }
  }*/

 

  Future<Response> updadteReview(
      {required String reviewId, String? ratings, String? title}) async {
    Map<String, dynamic> data = {
      'ratings': ratings,
    };
    if (title != null) data['title'] = title;
    if (ratings != null) data['ratings'] = ratings;

    try {
      return await _dio.put("/v1/review/$reviewId", data: data);
    } catch (e) {
      throw Exception("Failed to update review with id: $reviewId");
    }
  }

  Future<Response> deleteReview({required String reviewId}) async {
    try {
      return await _dio.delete("/v1/review/$reviewId");
    } catch (e) {
      throw Exception("Failed to delete review with id: $reviewId | error: $e");
    }
  }

  /*Future<Response> getmyService() async {
    try {
      return await _dio.get('/v1/service/getMyService');
    } catch (e) {
      throw Exception("Failed to fetch getmyService | error: $e");
    }
  }*/ 
}
