import 'package:flutter/material.dart';
import 'package:clientphase/models/review_model.dart';
import 'package:clientphase/services/api/review_api.dart';
import 'package:get/get.dart';

class ReviewControllerr extends ChangeNotifier {
  final ReviewApi reviewApi = ReviewApi();

  final serviceId = ''.obs;
  final ratings = ''.obs;
  var isLoading = true.obs;
  var reviewList = <Review>[].obs; // Adjusted variable name and type
  final title = ''.obs;

  

  fetchreview(String serviceId) async {
    try {
      isLoading(true);
      final response = await ReviewApi().getServiceReview(serviceId);
      reviewList.assignAll(response);
      notifyListeners(); // Notify listeners about the data change
    } catch (e) {
      print('Error fetching review data: $e');
    } finally {
      isLoading(false);
    }
  }


 Future<void> deletereview(String reviewId) async {
    try {
      await reviewApi.deleteReview(reviewId: reviewId);
      Get.snackbar(
        'Success',
        'Review deleted successfully.',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 3),
        backgroundColor: Colors.green,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to delete review: $e',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 3),
        backgroundColor: Colors.red,
      );
    }
  }
  Future<void> createReview(String serviceId) async {
    try {
     // print("controller $title.value");
      final Map<String, Object> ReviewData = {
        'serviceId': serviceId,
        'ratings': ratings,
          
      };
      await reviewApi.createReview(
          ReviewData,
          serviceId: serviceId,
          ratings: ratings.value,
          title: title.value); // Updated to use titleController.text
      Get.snackbar(
        'success',
        'Review created successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      clearFields();
    } catch (e) {
      print('Error creating review: $e');
      throw e;
    }
  }

  void showSnackbar(String message) {
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 10),
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }

  void clearFields() {
    serviceId.value = '';
    ratings.value = '';
    title.value = ''; // Clear the title controller
  }
}
