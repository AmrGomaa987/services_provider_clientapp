// lib/http_service.dart
import 'package:dio/dio.dart';

class HttpServiceForgetPassword {
  static const String baseUrl = 'https://homo.onrender.com/api';

  final Dio _dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future<void> forgetPassword( String email) async {
    try {
      final response = await _dio.post(
        '/v1/auth/forget-password',
        data: { 'email': email},
      );
      print(response);
      print(response.data);
      if (response.statusCode == 200) {
        //  successful
        try{
          print(response.data['data']['token']);
       //   await CacheHelper.saveData(key: 'token', value:response.data['data']['token']);
       //   print('save toke is done ');
        }catch(e){
          print('error when save token /');
        }

        //    print('Token]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]: ${loginModel.data!.token}');
        //
        return;
      } else {
        // Registration failed
        throw ('Login failed: ${response.data}');
      }
    } catch (e) {
      // Handle network or other errors
      throw ('Error during Login: $e');
    }
  }
}