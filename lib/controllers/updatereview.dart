import 'package:clientphase/services/api/review_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:clientphase/models/review_model.dart';
import 'package:clientphase/services/api/api.dart';
import 'package:get_storage/get_storage.dart';

class UpdateReviewController extends GetxController {
  final ReviewApi _reviewApi = ReviewApi();
  final Review review;
  UpdateReviewController(this.review);
  final title = ''.obs;
  final ratings = 0.0.obs;
 
  void onInit() {
    super.onInit();
   title.value = review.title ?? '';
    ratings.value = review.ratings ?? 0.0;
  }

  Future<void> updateReview({
    required String reviewId,
    String? ratings,
    String? title,
  }) async {
    try {
      await _reviewApi.updadteReview(
        reviewId: reviewId,
        ratings: ratings,
        title: title,
      );

      this.ratings.value = double.parse(ratings ?? '0.0');
      this.title.value = title ?? '';
      // If update is successful, you can perform any necessary actions here
        Get.snackbar(
        '',
        'تم تحديث المراجعة بنجاح!',
        backgroundColor: Colors.green,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 3),
      );
    } catch (e) {
      // Handle error, such as showing a snackbar or dialog
      //  Get.snackbar(
      //   'خطأ',
      //   'فشل تحديث المراجعة: $e',
      //   backgroundColor: Colors.red,
      //   snackPosition: SnackPosition.BOTTOM,
      //   duration: Duration(seconds: 3),
      // );
      // print('Failed to update review: $e');
    }
  }
}
