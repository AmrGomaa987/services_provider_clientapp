import 'dart:async';
import 'package:clientphase/chat/chat_screen.dart';
import 'package:clientphase/chat/chatcontroller.dart';
import 'package:clientphase/controllers/clinetbooking_controller.dart';
import 'package:clientphase/noconn.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingTap extends StatefulWidget {
  @override
  _BookingTapState createState() => _BookingTapState();
}

class _BookingTapState extends State<BookingTap> {
  final MyClinetBookingController _bookingController =
      Get.put(MyClinetBookingController());
        ChatController serviceController = Get.put(ChatController());


  late Timer _timer;

  @override
  void initState() {
    super.initState();
    // Fetch data initially
    _bookingController.fetchPendingBookings();
    // Set up timer for automatic refresh
    _timer = Timer.periodic(Duration(minutes: 5), (timer) {
      _bookingController.fetchPendingBookings();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
      
          if (_bookingController.isLoading.value) {
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
        if (_bookingController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (_bookingController.myBookings.isEmpty) {
          return Center(
            child: Text(
              'لا توجد حجوزات معلقه.',
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
          );
        } else {
          return RefreshIndicator(
            onRefresh: () => _bookingController.fetchPendingBookings(),
            child: ListView.builder(
              itemCount: _bookingController.myBookings.length,
              itemBuilder: (context, index) {
                var booking = _bookingController.myBookings[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                         width: double.infinity,
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Text(
                            //   'Booking ID: ${booking.id}',
                            //   style:
                            //       TextStyle(fontSize: 14, color: Colors.black),
                            // ),
                            // SizedBox(height: 8),
                            Text(
                              'الاسم: ${booking.user.name}',
                              style: TextStyle(
                                  fontSize: 14, color: Colors.black87),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'الوصف: ${booking.description}',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.black),
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
                          ],
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                         ElevatedButton(
                          onPressed: () {
                            _cancelBooking(booking.id);
                          },
                          child: Text(
                            'الغاء',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 14.0, horizontal: 18.0),
                          ),
                        ),
                         SizedBox(width: 8),
                          Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color(0xFF7210ff),
                              ),
                              child: IconButton(
                                  onPressed: () {
                                    Get.to(ChatScreen(
                                      receiverId: booking.provider.id,
                                      username: booking.provider.name,
                                    ));
                                    serviceController
                                        .createNewUserChat(booking.provider.id);
                                  },
                                  icon: Icon(
                                    Icons.chat,
                                    color: Colors.white,
                                  ))),
                        ],
                      ),
                     
                    ],
                  ),
                );
              },
            ),
          );
        }
      }),
      backgroundColor: Colors.white,
    );
  }

  void _cancelBooking(String bookingId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('تأكيد الالغاء'),
          content: Text('هل أنت متأكد أنك تريد إلغاء هذا الحجز؟'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('لا'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                _bookingController
                    .cancelBooking(bookingId); // Cancel the booking
              },
              child: Text('نعم'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        );
      },
    );
  }
}
