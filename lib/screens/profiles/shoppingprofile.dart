import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:clientphase/categories/CarouselSlider/carousel1.dart';
import 'package:clientphase/categories/plumbing_container/usercontainer.dart';
import 'package:clientphase/controllers/profile_controller.dart';
import 'package:clientphase/controllers/reviewcontroller.dart';
import 'package:clientphase/models/review_model.dart';
import 'package:clientphase/noconn.dart';
import 'package:clientphase/provider/review.dart';
import 'package:clientphase/screens/bookingview/newBooking.dart';
import 'package:clientphase/screens/profiles/fullscreean.dart';
import 'package:clientphase/screens/profiles/updatemyreview.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';

import '../../models/service_model.dart';

class ShoppingProfile extends StatefulWidget {
  ShoppingProfile({Key? key, required this.service}) : super(key: key);
  final Service service;
  @override
  _ShoppingProfileState createState() => _ShoppingProfileState();
}

class _ShoppingProfileState extends State<ShoppingProfile> {
  final ProfileController _profileController = Get.put(ProfileController());
  late Timer _timer;
  late ReviewController _reviewController;
  final _serviceIdController = TextEditingController();
  final _ratingsController = TextEditingController();
  final _titleController = TextEditingController();
  bool _isLoading = true;
  late Future<void> _fetchReviews;

  @override
  void initState() {
    super.initState();
    _reviewController = Get.put(ReviewController());
    fetchReviews();
    _buildProfileView();
    _timer = Timer.periodic(Duration(minutes: 5), (timer) {
      fetchReviews();
      _buildProfileView();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    Get.delete<ReviewController>();
    super.dispose();
  }

  Future<void> fetchReviews() async {
    final serviceId = widget.service.id.toString();
    await _reviewController.fetchReview(serviceId);
    if (mounted) {
      setState(() {});
    }
  }
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  Future<void> _loadData() async {
    fetchReviews();
  }

  Future<void> _handleRefresh() async {
    await _loadData();
  }

  // fetchReviews() async {
  //   final serviceId = widget.service.id.toString();
  //   await _reviewController.fetchreview(serviceId);
  //   if (mounted) {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   }
  // }
  

  bool isDescriptionExpanded = false;
  int selectedContainerIndex = -1;
  int likeCount = 5;
  int dislikeCount = 100;
  int _currentIndex = 0; // Index of the currently selected service

  bool isLiked = false;
  bool isDisliked = false;
  //////////////////////////
  int likeCount1 = 0;
  int dislikeCount1 = 0;

  bool isLiked1 = false;
  bool isDisliked1 = false;
  ///////////////////////
  int likeCount2 = 0;
  int dislikeCount2 = 0;

  bool isLiked2 = false;
  bool isDisliked2 = false;

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.service.provider["name"]),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.back();
          },
        ),
        elevation: 0,
      ),
      body: Obx(() {
        if (_reviewController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return _buildProfileView();
        }
      }),
    );
  }
  Widget _buildProfileView() {
    return 
     StreamBuilder<ConnectivityResult>(
        stream: Connectivity().onConnectivityChanged,
        builder: (context, snapshot) {
          return snapshot.data==ConnectivityResult.none?
          const NoConnectionWidget()
          : 
    Scaffold(
      backgroundColor: Colors.white,
      body: ChangeNotifierProvider<ReviewControllerr>(
        create: (_) => ReviewControllerr(),
        child: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: _handleRefresh,
          child: Consumer<ReviewControllerr>(
            builder: (context, reviewController, child) {
              return ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  final service = widget.service;
                  return Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                 CarouselSlider(
                options: CarouselOptions(
                  height: 200.0,
                  autoPlay: false,
                  enlargeCenterPage: true,
                  viewportFraction: 0.9,
                ),
                items: [
                  GestureDetector(
                    onTap: () {
                      Get.to(() => FullScreenImage(
                        imageUrls: [service.coverImage], // Only cover image
                        initialIndex: 0,
                      ));
                    },
                    child: Image.network(
                      service.coverImage,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                ],
              ),

       SizedBox(height: 10,),
                      Row(
          children: [
            SizedBox(
              height: 35,
              width: 25,
            ),
            Expanded(
              child: Text(
                service.title,
                style: TextStyle(
                  fontSize: 20, 
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis, // Add this line to handle text overflow
              ),
            ),
            SizedBox(
              height: 30,
              width: 75,
            ),
          ],
        ),

                      Row(
                        children: [
                          SizedBox(
                            height: 35,
                            width: 25,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 30,
                          ),
                          SizedBox(width: 8),
                          Text(
                            _reviewController.averageRating.toStringAsFixed(1),
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    Row(
                    children: [
                      SizedBox(
                            height: 35,
                            width: 25,
                          ), 
                      Text(
                        '${_reviewController.totalRatings} مراجعات',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                      Row(
                        children: [
                          SizedBox(
                            height: 35,
                            width: 25,
                          ),
                          Icon(
                            Icons.location_on_rounded,
                            color: Color(0xFF7210ff),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(service.location,
                              style: TextStyle(fontSize: 10)),
                        ],
                      ),
                      // Row(
                      //   children: [
                      //     SizedBox(
                      //       height: 35,
                      //       width: 25,
                      //     ),
                      //     Text(
                      //       '${service.price.toString()} LE',
                      //       style: TextStyle(
                      //         fontSize: 20,
                      //         fontWeight: FontWeight.bold,
                      //         color: Color(0xFF7210ff),
                      //       ),
                      //     ),
                      //     SizedBox(
                      //       width: 10,
                      //     ),
                      //     Text('(السعر )', style: TextStyle(fontSize: 10)),
                      //   ],
                      // ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 280,
                        child: Divider(
                          thickness: 1,
                          color: const Color.fromARGB(255, 224, 218, 218),
                        ),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            height: 35,
                            width: 25,
                          ),
                          Text(
                            'نبذة تعريفية',
                            style: TextStyle(
                              fontSize: 18,
                              // fontWeight: FontWeight.bold,
                              color: Color(0xFF7210ff),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          service.description,
                          style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontSize: 16,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          SizedBox(
                            height: 35,
                            width: 25,
                          ),
                          Text(
                            'صور ومقاطع فيديو',
                            style: TextStyle(
                                fontSize: 18,
                               
                                color: Color(0xFF7210ff)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                         CarouselSlider(
                  options: CarouselOptions(
                    height: 200.0,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    viewportFraction: 0.9,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                  ),
                  items: service.images?.map((serviceimg) {
                    int index = service.images!.indexOf(serviceimg);
                    return Builder(
                      builder: (BuildContext context) {
                        return GestureDetector(
                          onTap: () {
                            Get.to(() => FullScreenImage(
                              imageUrls: service.images!,
                              initialIndex: index,
                            ));
                          },
                          child: Container(
                            margin: EdgeInsets.all(5.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                serviceimg,
                                fit: BoxFit.cover,
                                width: 350,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),

                DotsIndicator(
                  dotsCount: service.images?.length ?? 0,
                  position: _currentIndex.toDouble(),
                  decorator: DotsDecorator(
                    size: const Size.square(8.0),
                    activeSize: const Size(20.0, 8.0),
                    activeShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
                          ],
                        ),
                      ),
                     
                      SizedBox(height: 20),
                      Row(
                        children: [
                          SizedBox(height: 35, width: 25),
                          Text(
                            'التقييمات والمراجعات',
                            style: TextStyle(
                              fontSize: 18,
                              // fontWeight: FontWeight.bold,
                              color: Color(0xFF7210ff),
                            ),
                          ),
                        ],
                      ),
                     Obx(() {
                      if (_reviewController.isLoading.value) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        if (_reviewController.reviewList.isEmpty) {
                          return Center(
                            child: Text('لا يوجد تعليقات'),
                          );
                        } else {
                          return ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount: _reviewController.reviewList.length,
                            itemBuilder: (context, index) {
                              final review = _reviewController.reviewList[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: UserReview(
                                  userName: review.user['name'],
                                  image: review.user['profileImage'] != null
                                      ? NetworkImage(review.user['profileImage'])
                                      : null,
                                  rating: review.ratings.toDouble(),
                                  reviewText: review.title ?? '',
                                  // createdTime: review.createdAt,
                                  // updatedTime: review.updatedAt,
                                  onTap: () {
                                    final userData = _profileController.profileData.value;
                                    print(userData.id);
                                    print(review.user['_id']);
                                    if (userData.id == review.user['_id']) {
                                      Get.to(UpdateReviewScreen(review: review));
                                    } else {
                                      Get.snackbar(
                                        'تم رفض الإذن',
                                        'ليس لديك الإذن بتعديل هذا التعليق.',
                                        backgroundColor: Colors.red,
                                        snackPosition: SnackPosition.BOTTOM,
                                        duration: Duration(seconds: 3),
                                      );
                                    }
                                  },
                                  onTap1: () {
                                    final userData = _profileController.profileData.value;
                                    print(userData.id);
                                    print(review.user['_id']);
                                    if (userData.id == review.user['_id']) {
                                      _reviewController.deleteReview(review.id);
                                    } else {
                                      Get.snackbar(
                                        'تم رفض الإذن',
                                        'ليس لديك الإذن بمسح هذا التعليق.',
                                        snackPosition: SnackPosition.BOTTOM,
                                        duration: Duration(seconds: 3),
                                        backgroundColor: Colors.red,
                                      );
                                    }
                                  },
                                ),
                              );
                            },
                          );
                        }
                      }
                    }),

                      SizedBox(height: 30),
                      Text(
                        'أترك تقييمك',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              blurRadius: 4,
                              color: Color(0xFF7210ff).withOpacity(0.3),
                              offset: Offset(2, 2),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: RatingBar.builder(
                          initialRating: 0,
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
                            _reviewController.ratings.value = rating.toString();
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: TextField(
                          controller: _titleController,
                          onChanged: (value) =>
                              _reviewController.title.value = value,
                          maxLines: 4,
                          decoration: InputDecoration(labelText: 'شارك بتعليق'),
                        ),
                      ),
                      SizedBox(height: 16.0),
                     Center(
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_titleController.text.isEmpty) {
                                  Get.snackbar(
                                    '', 
                                    "لا يمكنك ترك تعليق فارغ",
                                    snackPosition: SnackPosition.BOTTOM,
                                    duration: Duration(seconds: 5),
                                  );
                                  return;
                                }

                                try {
                                  await _reviewController.createReview(service.id.toString());
                                  _serviceIdController.clear();
                                  _titleController.clear();
                                } catch (e) {
                                  Get.snackbar(
                                    '', 
                                    "لا يمكنك انشاء اكثر من تعليق",
                                    snackPosition: SnackPosition.BOTTOM,
                                    duration: Duration(seconds: 5),
                                  );
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
                                  'انشي تعليقك!',
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

                      SizedBox(
                        height: 30,
                      ),
                      // "Book Now" Button
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: ElevatedButton(
                            onPressed: () => _onServiceTap(service),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              backgroundColor: Color(0xFF7210ff),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                'احجز الان !',
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  });}

  IconData _getRatingIcon(double rating) {
    if (rating >= 4.5) {
      return Icons.star;
    } else if (rating >= 3.0) {
      return Icons.star_half;
    } else {
      return Icons.star_border;
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>(
        'isDescriptionExpanded', isDescriptionExpanded));
    properties.add(DiagnosticsProperty<bool>(
        'isDescriptionExpanded', isDescriptionExpanded));
  }

  void _onServiceTap(Service service) {
    Get.to(
        () => BookingVieww(serviceId: service.id.toString(), service: service));
  }
}
