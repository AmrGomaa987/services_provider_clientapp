import 'package:clientphase/services/api/api.dart';
import 'package:dio/dio.dart';

class AddressApi {
  final Dio _dio = DioClient().dio;

  Future<Response> addAddress(
      {required String alias,
      required String details,
      required String phone,
      required String city,
      required String postalCode}) async {
    Map<String, dynamic> data = {
      'alias': alias,
      'details': details,
      'phone': phone,
      'city': city,
      "postalCode": postalCode,
    };

    try {
      return await _dio.post("/v1/address", data: data);
    } catch (e) {
      throw Exception("Failed to add address | error: $e");
    }
  }

  Future<Response> getAllAddresses() async {
    try {
      return await _dio.get('/v1/address');
    } catch (e) {
      throw Exception("Failed to get addresses | error: $e");
    }
  }

  Future<Response> removeAddress({required String addressId}) async {
    try {
      return await _dio.delete("/v1/address", data: {"addressId": addressId});
    } catch (e) {
      throw Exception("Failed to remove address | error: $e");
    }
  }
}
