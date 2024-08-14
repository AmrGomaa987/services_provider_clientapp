//CONTROLLER

import 'package:clientphase/models/review_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:clientphase/services/api/review_api.dart';

class ReviewController extends GetxController {
  final ReviewApi reviewApi = ReviewApi();

  final serviceId = ''.obs;
  final ratings = ''.obs;
  var isLoading = true.obs;
  var reviewList = <Review>[].obs;
  final title = ''.obs;
  final averageRating = 0.0.obs;
  final totalRatings = 0.obs;
  @override
  void onInit() {
    super.onInit();
    fetchReview(serviceId.value);
  }

 Future<void> fetchReview(String serviceId) async {
    try {
      isLoading(true);
      final response = await reviewApi.getServiceReview(serviceId);
      reviewList.assignAll(response);
      calculateRatings();
    } catch (e) {
      print('Error fetching review data: $e');
    } finally {
      isLoading(false);
      update(); // Update the controller
    }
  }

  Future<void> deleteReview(String reviewId) async {
    try {
      await reviewApi.deleteReview(reviewId: reviewId);
      Get.snackbar(
        '',
        'تم حذف المراجعة بنجاح.',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 3),
        backgroundColor: Colors.green,
      );
      fetchReview(serviceId.value); // Refresh reviews after deletion
    } catch (e) {
      Get.snackbar(
        'خطأ',
        'فشل في حذف المراجعة: $e',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 3),
        backgroundColor: Colors.red,
      );
    }
  }

  Future<void> createReview(String serviceId) async {
    try {
      final Map<String, Object> reviewData = {
        'serviceId': serviceId,
        'ratings': ratings.value,
        'title': title.value,
      };
      await reviewApi.createReview(
        reviewData,
        serviceId: serviceId,
        ratings: ratings.value,
        title: title.value,
      );
      Get.snackbar(
        '',
        'تم إنشاء المراجعة بنجاح',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      clearFields();
      fetchReview(serviceId); // Refresh reviews after creation
    } catch (e) {
      print('Error creating review: $e');
      throw e;
    }
  }

  void clearFields() {
    serviceId.value = '';
    ratings.value = '';
    title.value = '';
  }

  void calculateRatings() {
    double total = 0;
    reviewList.forEach((review) {
      total += review.ratings;
    });
    averageRating.value = reviewList.isEmpty ? 0 : total / reviewList.length;
    totalRatings.value = reviewList.length;
  }
}