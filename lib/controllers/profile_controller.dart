import 'dart:io';

import 'package:clientphase/models/user_model.dart';
import 'package:clientphase/services/api/profile_api.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';


class ProfileController extends GetxController {
  final profileApi = ProfileApi();
  var profileData = User(id: '', name: '', email: '', role: 'user').obs;
  var isLoading = false.obs;
  var error = ''.obs;
var hasConnection = true.obs;
  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    try {
      isLoading(true);
      final response = await profileApi.getMe();
      final fetchedUser = User.fromJson(response.data['data']);
      hasConnection(true);

      profileData.value = fetchedUser;
    } catch (e) {
      hasConnection(false);

      error.value = 'Failed to fetch profile';
    } finally {
      isLoading(false);
      update();
    }
  }

  Future<void> updateProfile(
      {String? name, String? email, File? profileImage, String? bio}) async {
    try {
      isLoading(true);
      final response = await profileApi.updateMe(
          name: name, email: email, profileImage: profileImage, bio: bio);
      final fetchedUser = User.fromJson(response.data['data']);
      profileData.value = fetchedUser;
    } catch (e) {
      error.value = 'فشل في تحديث الملف الشخصي';
    } finally {
      isLoading(false);
      update();
    }
  }
Future<void> updateMyPassword({
  required String oldPassword,
  required String newPassword,
  required String passwordConfirm,
}) async {
  try {
    isLoading(true);
    final response = await profileApi.updateMyPassword(
      oldPassword: oldPassword,
      newPassword: newPassword,
      passwordConfirm: passwordConfirm,
    );
    final token = response.data["token"];
    // TODO: Store token
  } on WrongOldPasswordException {
    error.value = 'كلمة السر القديمة غير صحيحة';
    throw WrongOldPasswordException();
  } catch (e) {
    error.value = 'فشل تحديث كلمة المرور';
    throw e;
  } finally {
    isLoading(false);
    update();
  }
}

// Future<void> updateMyPassword({
//     required String oldPassword,
//     required String newPassword,
//     required String passwordConfirm,
//   }) async {
//     try {
//       isLoading(true);
//       final response = await profileApi.updateMyPassword(
//         oldPassword: oldPassword,
//         newPassword: newPassword,
//         passwordConfirm: passwordConfirm,
//       );
//       final token = response.data["token"];
//       // TODO: Store token
//     } catch (e) {
//       error.value = 'فشل تحديث كلمة المرور';
//     } finally {
//       isLoading(false);
//       update();
//     }
//   }
}
class WrongOldPasswordException implements Exception {
  final String message;
  WrongOldPasswordException([this.message = '']);

  @override
  String toString() {
    return message.isEmpty ? "WrongOldPasswordException" : message;
  }
}
