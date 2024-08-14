import 'dart:async';
import 'package:clientphase/noconn.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:clientphase/controllers/completebooking_controller.dart';

class CompleteBookingScreen extends StatefulWidget {
  @override
  _CompleteBookingScreenState createState() => _CompleteBookingScreenState();
}

class _CompleteBookingScreenState extends State<CompleteBookingScreen> {
  final CompleteBookingController _completeBookingController =
      Get.put(CompleteBookingController());

  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _fetchBookings();
    // Set up timer for automatic refresh
    _timer = Timer.periodic(Duration(minutes: 5), (timer) {
      _fetchBookings();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    Get.delete<CompleteBookingController>();
    super.dispose();
  }

  Future<void> _fetchBookings() async {
    await _completeBookingController.fetchCompletedBookings();
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
      
          if (_completeBookingController.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          } else {
            return _buildProfileView();
          }
       
      }),
    );
  }

  Widget _buildProfileView() {
    return Scaffold(
      body: Obx(() {
        if (_completeBookingController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (_completeBookingController.completedBookings.isEmpty) {
          return Center(
            child: Text(
              'لا توجد حجوزات مكتملة متاحة',
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
          );
        } else {
          return RefreshIndicator(
            onRefresh: () =>
                _completeBookingController.fetchCompletedBookings(),
            color: Color(0xFF7210ff),
            child: ListView.builder(
              itemCount: _completeBookingController.completedBookings.length,
              itemBuilder: (context, index) {
                var booking =
                    _completeBookingController.completedBookings[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Center(
                      child: Container(
                         width: double.infinity,
                        padding: EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(255, 43, 114, 28)
                                  .withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'الاسم: ${booking.user.name}',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.black),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'الوصف: ${booking.description}',
                              style: TextStyle(
                                  fontSize: 14, color: Colors.black87),
                            ),
                            SizedBox(height: 8),
                            Text(
                                  'تاريخ بداية الخدمة: ${booking.startDate.toLocal().toString().split(' ')[0]}',
                                  style: TextStyle(fontSize: 14)),
                            SizedBox(height: 8),
                           Text(
                                  'تاريخ نهاية الخدمة: ${booking.endDate.toLocal().toString().split(' ')[0]}',
                                  style: TextStyle(fontSize: 14)),
                            SizedBox(height: 8),
                            Text(
                              'السعر: ${booking.price}',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.black),
                            ),
                             SizedBox(height: 8),
                              Text(
                                  'اسم مقدم الخدمة: ${booking.provider.name}',
                                  style: TextStyle(fontSize: 14)),
                                     SizedBox(height: 8),
                            Text(
                              'العنوان: ${booking.address.city}',
                              style: TextStyle(fontSize: 14, color: Colors.black),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'الكود البريدي:  ${booking.address.postalCode}',
                              style: TextStyle(fontSize: 14, color: Colors.black),
                            ),
                            SizedBox(height: 8),
                             Text('رقم الهاتف: ${booking.address.phone}',
                          style: TextStyle(fontSize: 14)),
                              SizedBox(height: 8),
                              Text('اسم الخدمة: ${booking.service}',
                                  style: TextStyle(fontSize: 14)),
                            if (booking.rejectReason != null) ...[
                              SizedBox(height: 8),
                              Text(
                                'سبب الرفض: ${booking.rejectReason}',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black),
                              ),
                            ],
                            SizedBox(height: 8),
                            if (booking.ispaid)
                              Center(
                                child: ElevatedButton(
                                  onPressed: () {
                                    _completeBooking(booking.id);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Colors.green, // Button color
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 24, vertical: 12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Text(
                                    'تأكيد',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                  ],
                );
              },
            ),
          );
        }
      }),
      backgroundColor: Colors.white,
    );
  }

  void _completeBooking(String bookingId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('تأكيد الحجز'),
          content: Text('هل أنت متأكد أنك تريد إكمال هذا الحجز؟'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('لا'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                _completeBookingController
                    .completeBooking(bookingId); // Complete the booking
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Button color
              ),
              child: Text('نعم',
              style: TextStyle(color: Colors.white),),
            ),
          ],
        );
      },
    );
  }
}
