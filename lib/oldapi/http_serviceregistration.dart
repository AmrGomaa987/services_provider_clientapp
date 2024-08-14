
// lib/http_service.dart 
import 'package:clientphase/oldapi/saftoken.dart';
import 'package:dio/dio.dart'; 
 
class HttpServiceRegistration { 
  static const String baseUrl = 'https://homo.onrender.com/api'; 
 
  final Dio _dio = Dio(BaseOptions(baseUrl: baseUrl)); 
 
  Future<void> registerUser( 
      String name, String email, String password, String cpassword) async { 
    try { 
      final response = await _dio.post( 
        '/v1/auth/register', 
        data: { 
          'name': name, 
          'email': email, 
          'password': password, 
          'passwordConfirm': cpassword 
        }, 
      ); 
      print(response); 
      if (response.statusCode == 200) { 
        // Registration successful 
     TokenManager.saveToken(response.data['data']['token']); 
 
        return; 
      } else { 
        // Registration failed 
        throw ('Registration failed: ${response.data}'); 
      } 
    } catch (e) { 
      // Handle network or other errors 
      throw ('Error during registration: $e'); 
    } 
  } 
}

