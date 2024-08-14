import 'package:dio/dio.dart';

class HttpServiceResetPassword {
  static const String baseUrl = 'https://homo.onrender.com/api';

  final Dio _dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future<void> resetPassword(String password , String passwordConfirm ,
      String email ) async {
    try {
      print('from api email = $email');
      print('from api password = $password');
      print('from api passwordConfirm = $passwordConfirm');
      final response = await _dio.post(
        '/v1/auth/reset-password',
        data: { 'email':email ,'password':password ,'passwordConfirm':passwordConfirm},
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
        throw (' failed: ${response.data}');
      }
    } catch (e) {
      print(e);
      // Handle network or other errors
      throw ('Error during Login: $e');
    }
  }
}