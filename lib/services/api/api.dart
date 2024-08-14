import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioClient {
  static final DioClient _singleton = DioClient._internal();
  static const String _tokenKey = 'token';
  factory DioClient() {
    return _singleton;
  }

  String baseUrl = 'https://homo.onrender.com/api';
  late Dio _dio;

  DioClient._internal() {
    BaseOptions options = BaseOptions(baseUrl: baseUrl);

    _dio = Dio(options);

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest:
          (RequestOptions options, RequestInterceptorHandler handler) async {
        // Attach token to header if it's not null
        String? token =await getToken(); // Your method to get the token
        if (token != null) {
          options.headers["Authorization"] = "Bearer $token";
        }
        handler.next(options);
      },
    ));
  }

  Dio get dio => _dio;

  
  static Future<String?> getToken() async {  
    final prefs = await SharedPreferences.getInstance();  
    return prefs.getString(_tokenKey);  
  }  

}
