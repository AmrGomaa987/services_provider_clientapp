
// import 'package:clientphase/models/review_model.dart';
// import 'package:clientphase/services/api/review_api.dart';
// import 'package:flutter/foundation.dart';
// import 'package:get/get.dart';

// class UpdateReviewControllerr extends ChangeNotifier {
//   final ReviewApi _reviewApi = ReviewApi();
//   late Review review;

//   final title = ''.obs;
//   final ratings = 0.0.obs;

  

//   Future<void> updateReview({
//     required String reviewId,
//     String? ratings,
//     String? title,
//   }) async {
//     try {
//       await _reviewApi.updadteReview(
//         reviewId: reviewId,
//         ratings: ratings,
//         title: title,
//       );

//       this.ratings.value = double.parse(ratings ?? '0.0');
//       this.title.value = title ?? '';
//       // If update is successful, you can perform any necessary actions here
//       notifyListeners(); // Notify listeners about the data change
//     } catch (e) {
//       // Handle error, such as showing a snackbar or dialog
//       print('Failed to update review: $e');
//     }
//   }
// }
