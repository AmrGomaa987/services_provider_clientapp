import 'package:clientphase/services/api/api.dart';
import 'package:dio/dio.dart';

class ChatApi {
  final Dio _dio = DioClient().dio;

  Future<Response> getAllUserChats() async {
    try {
      return await _dio.get('/v1/chat');
    } catch (e) {
      throw Exception('Failed to fetch user chats $e');
    }
  }

  Future<Response> createNewUserChat(String reciverId) async {
    try {
      return await _dio.post('/v1/chat/$reciverId');
    } catch (e) {
      throw Exception('Failed to create  new user chat $e');
    }
  }
}
