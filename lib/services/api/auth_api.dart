import 'dart:io';

import 'package:clientphase/services/api/api.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

class AuthApi {
  final Dio _dio = DioClient().dio;

  Future<Response> register(
      {required String name,
      required String email,
      required String password,
      File? profileImage,
      String? bio}) async {
    FormData formData = FormData();

    formData.fields.add(MapEntry('name', name));
    formData.fields.add(MapEntry('email', email));
    formData.fields.add(MapEntry('password', password));

    if (profileImage != null) {
      String fileName = profileImage.path.split('/').last;
      var fileExt = fileName.split('.').last;
      formData.files.add(MapEntry(
        'profileImage',
        MultipartFile.fromFileSync(profileImage.path,
            contentType: MediaType("image", fileExt)),
      ));
    }

    if (bio != null && bio.isNotEmpty) {
      formData.fields.add(MapEntry('bio', bio));
    }

    try {
      return await _dio.post('/v1/auth/register', data: formData);
    } catch (e) {
      throw Exception('Failed to register $e');
    }
  }

  Future<Response> login(
      {required String email, required String password}) async {
    Map<String, dynamic> data = {
      'email': email,
      'password': password,
    };

    try {
      return await _dio.post('/v1/auth/login', data: data);
    } catch (e) {
      throw Exception('Failed to login $e');
    }
  }

  Future<Response> forgotPassword({required String email}) async {
    Map<String, dynamic> data = {
      'email': email,
    };

    try {
      return await _dio.post('/v1/auth/forget-password', data: data);
    } catch (e) {
      throw Exception('Failed to forget-password $e');
    }
  }

  Future<Response> confirmReset({required String resetCode}) async {
    Map<String, dynamic> data = {
      'resetCode': resetCode,
    };

    try {
      return await _dio.post('/v1/auth/confirm-reset', data: data);
    } catch (e) {
      throw Exception('Failed to confirmReset $e');
    }
  }

  Future<Response> resetPassword(
      {required String email,
      required String password,
      required String passwordConfirm}) async {
    Map<String, dynamic> data = {
      'email': email,
      'password': password,
      'passwordConfirm': passwordConfirm
    };

    try {
      return await _dio.post('/v1/auth/reset-password', data: data);
    } catch (e) {
      throw Exception('Failed to reset password $e');
    }
  }
}
