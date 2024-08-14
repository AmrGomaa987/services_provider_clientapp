// lib/http_service.dart
import 'package:clientphase/network/local/cach_helper.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class HttpServiceLogin {
  static const String baseUrl = 'https://homo.onrender.com/api';

  final Dio _dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future<void> loginUser(String email, String password) async {
    print(email);
    print(password);
    try {
      final response = await _dio.post(
        '/v1/auth/login',
        data: {'email': email, 'password': password},
      );
      print(response);
      if (response.statusCode == 200) {
        // Login successful
        try {
          print(response.data['data']['token']);
          await CacheHelper.saveData(
              key: 'token', value: response.data['data']['token']);
          print('save toke is done ');
        } catch (e) {
          print('error when save token /');
        }
        return;
      } else {
        // Registration failed
        throw (Get.snackbar("خطأ", "رجاء ادخال بيانات صحيحة",
            snackPosition: SnackPosition.BOTTOM,
            duration: Duration(seconds: 5)));
//'Login failed: ${response.data}'
      }
    } catch (e) {
      // Handle network or other errors
      throw (Get.snackbar("خطأ", "رجاء ادخال بيانات صحيحة",
          snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 5)));
      //'Error during Login: $e'
    }
  }
}
