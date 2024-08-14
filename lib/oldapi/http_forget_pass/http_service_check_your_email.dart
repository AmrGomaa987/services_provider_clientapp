// lib/http_service.dart
import 'package:dio/dio.dart';
class HttpServiceCheckEmail {
  static const String baseUrl = 'https://homo.onrender.com/api';

  final Dio _dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future<void> checkEmail(String code) async {
    try {
      final response = await _dio.post(
        '/v1/auth/confirm-reset',
        data: { 'resetCode':code},
      );
      print('}}}}}}}}}}}}}}}}}code = $code');
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
        throw (' failed: ${response.data}');
      }
    } catch (e) {
      print(e);
      // Handle network or other errors
      throw ('Error during Login: $e');
    }
  }
}