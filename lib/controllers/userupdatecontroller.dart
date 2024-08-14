import 'package:clientphase/constants/api_constants.dart';
import 'package:clientphase/models/userupdatemodel.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio; // Alias dio package

class UserController extends GetxController {
  var user = UserModel(
    id: '',
    name: '',
    email: '',
    profileImage: '',
    role: '',
    createdAt: '',
    updatedAt: '',
    bio: '',
  ).obs;

  var headers = {
    'Authorization':
        'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NWUwYzgwMzI2N2VjZmUwN2RjZmUxYjYiLCJpYXQiOjE3MDkyMzAwODMsImV4cCI6MTc0MDc2NjA4M30.I0hYuDNoMbXEstdAl6TJ_RO0XJzM45-FzjLpgor8aHQ',
  };
  updateUserProfile(dio.FormData data) async {
    // Use dio.FormData
    var dioInstance = dio.Dio(); // Use dio.Dio
    try {
      dioInstance.options.headers = headers;
      var response = await dioInstance.put(
        // Use dioInstance instead of dio
        '${APIConstants.baseURL}${APIConstants.updateUserProfileEndpoint}',
        data: data,
      );

      if (response.statusCode == 200) {
        var userData = UserModel.fromJson(response.data['data']);
        user.value = userData;
      } else {
        print('Failed to update profile: ${response.statusMessage}');
      }
    } catch (e) {
      print('Error updating profile: $e');
    }
  }
}
