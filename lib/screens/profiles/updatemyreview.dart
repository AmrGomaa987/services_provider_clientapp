import 'dart:async';

import 'package:clientphase/controllers/reviewcontroller.dart';
import 'package:clientphase/controllers/updatereview.dart';
import 'package:clientphase/noconn.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:clientphase/models/review_model.dart';

class UpdateReviewScreen extends StatefulWidget {
  final Review review;

  UpdateReviewScreen({Key? key, required this.review}) : super(key: key);

  @override
  _UpdateReviewScreenState createState() => _UpdateReviewScreenState();
}

class _UpdateReviewScreenState extends State<UpdateReviewScreen> {
  late Timer _timer;
  late final UpdateReviewController _updateReviewController;

  Future<void> _fetchProfile() async {
    try {
      await _updateReviewController.updateReview(reviewId: widget.review.id);
    } catch (e) {
      print('Error fetching review: $e');
    }
  }

  _loadData() async {
    await _fetchProfile();
  }

  @override
  void initState() {
    super.initState();
    _updateReviewController = Get.put(UpdateReviewController(widget.review));
    _timer = Timer.periodic(Duration(minutes: 5), (timer) {
      _loadData();
      _updateReviewController = Get.put(UpdateReviewController(widget.review));
    });
    _loadData();
  }

  @override
  void dispose() {
    _timer.cancel();
    Get.delete<UpdateReviewController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  StreamBuilder<ConnectivityResult>(
        stream: Connectivity().onConnectivityChanged,
        builder: (context, snapshot) {
          return snapshot.data==ConnectivityResult.none?
          const NoConnectionWidget()
          : 
    Scaffold(
      appBar: AppBar(
        title: Text('تحديث المراجعة'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'قم بتحديث المراجعة الخاصة بك',
                style: TextStyle(
                  fontSize: 20,
                  
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: RatingBar.builder(
                initialRating: widget.review.ratings.toDouble(),
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  _updateReviewController.ratings.value = rating.toDouble();
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                controller: TextEditingController(
                    text: _updateReviewController.title.value),
                onChanged: (value) =>
                    _updateReviewController.title.value = value,
                maxLines: 1,
                decoration: InputDecoration(
                  labelText: 'عنوان المراجعة',
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Center(
  child: Padding(
    padding: EdgeInsets.only(bottom: 10),
    child: ElevatedButton(
                  onPressed: () {
                    if (_updateReviewController.title.value.isEmpty) {
                                Fluttertoast.showToast(
                                  msg: 'يرجى كتابة تعليق قبل تحديث المراجعة',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 5,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0,
                                );
                              }  else {
                      _updateReviewController.updateReview(
                        reviewId: widget.review.id,
                        ratings: _updateReviewController.ratings.value.toString(),
                        title: _updateReviewController.title.value,
                      );
                      final reviewController = Get.find<ReviewController>();
                      reviewController.fetchReview(widget.review.id);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    backgroundColor: Color(0xFF7210ff),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'تحديث المراجعة',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }); }
}
