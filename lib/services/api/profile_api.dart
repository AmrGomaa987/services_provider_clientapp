import 'dart:io';
import 'package:clientphase/services/api/api.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http_parser/http_parser.dart';

class ProfileApi {
  final Dio _dio = DioClient().dio;

  Future<Response> getMe() async {
    try {
      final res = await _dio.get('/v1/users/getMe');

      // send FCM token
      FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
      final token = await firebaseMessaging.getToken();
      await _dio.post("/v1/users/fcm-token", data: {"FCMToken": token});

      return res;
    } catch (e) {
      throw Exception('Failed to fetch user profile $e');
    }
  }

  Future<Response> updateMe(
      {String? name, String? email, File? profileImage, String? bio}) async {
    FormData formData = FormData();

    if (name != null) formData.fields.add(MapEntry('name', name));
    if (email != null) formData.fields.add(MapEntry('email', email));

    if (profileImage != null) {
      String fileName = profileImage.path.split('/').last;
      var fileExt = fileName.split('.').last;
      formData.files.add(MapEntry(
        'profileImage',
        MultipartFile.fromFileSync(profileImage.path,
            contentType: MediaType("image", fileExt)),
      ));
    }

    if (bio != null) formData.fields.add(MapEntry('bio', bio));

    try {
      return await _dio.put('/v1/users/updateMe', data: formData);
    } catch (e) {
      throw Exception('Failed to update user profile $e');
    }
  }

  Future<Response> updateMyPassword(
      {required String oldPassword,
      required String newPassword,
      required String passwordConfirm}) async {
    Map<String, dynamic> data = {
      'oldPassword': oldPassword,
      'newPassword': newPassword,
      'newPasswordConfirm': passwordConfirm,
    };

    try {
      return await _dio.put('/v1/users/changeMyPassword', data: data);
    } catch (e) {
      throw Exception('Failed to update password $e');
    }
  }

  Future<Response> deleteMe() async {
    try {
      return await _dio.delete('/v1/users/deleteMe');
    } catch (e) {
      throw Exception('Failed to delete profile $e');
    }
  }
}
