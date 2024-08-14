import 'dart:async';
import 'package:clientphase/noconn.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:clientphase/chat/chat_screen.dart';
import 'package:clientphase/chat/chatcontroller.dart';
import 'package:clientphase/chat/user_chat.dart';
import 'package:clientphase/controllers/acceptedbook.dart';
import 'package:clientphase/controllers/clinetbooking_controller.dart';

class acceptedTab extends StatefulWidget {
  final UserChat? userchat;
  acceptedTab({Key? key, this.userchat}) : super(key: key);

  _acceptedTabState createState() => _acceptedTabState();
}

class _acceptedTabState extends State<acceptedTab> {
  final AcceptBookingController _bookingController =
      Get.put(AcceptBookingController());
  ChatController serviceController = Get.put(ChatController());

  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _fetchBookings();
    _timer = Timer.periodic(Duration(minutes: 5), (timer) {
      _fetchBookings();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    Get.delete<AcceptBookingController>();
    super.dispose();
  }

  Future<void> _fetchBookings() async {
    await _bookingController.fetchPendingBookings();
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
              'لا توجد حجوزات مؤكدة.',
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
          );
        } else {
          return RefreshIndicator(
            onRefresh: () => _bookingController.fetchPendingBookings(),
            color: Color(0xFF7210ff),
            child: ListView.builder(
              itemCount: _bookingController.myBookings.length,
              itemBuilder: (context, index) {
                var booking = _bookingController.myBookings[index];
                return ListTile(
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                           width: double.infinity,
                          padding: EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
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
                              Text(
                                'الاسم: ${booking.user.name}',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black),
                              ),
                              SizedBox(height: 8),
                              Text('الوصف: ${booking.description}',
                                  style: TextStyle(fontSize: 14)),
                              SizedBox(height: 8),
                              Text(
                                  'تاريخ بداية الخدمة: ${booking.startDate.toLocal().toString().split(' ')[0]}',
                                  style: TextStyle(fontSize: 14)),
                              SizedBox(height: 8),
                              Text(
                                  'تاريخ نهاية الخدمة: ${booking.endDate.toLocal().toString().split(' ')[0]}',
                                  style: TextStyle(fontSize: 14)),
                              SizedBox(height: 8),
                              Text('السعر: ${booking.price}',
                                  style: TextStyle(fontSize: 14)),
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
                                Text('سبب الرفض: ${booking.rejectReason}',
                                    style: TextStyle(fontSize: 14)),
                              ],
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              _completeBooking(booking.id);
                            },
                            child: Text('مكتمل',
                                style: TextStyle(
                                    fontSize: 16.0, color: Colors.white)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 20.0),
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

  void _completeBooking(String bookingId) {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('اكمل الحجز'),
          content: Text('هل أنت متأكد أنك تريد تأكيد هذا الحجز؟'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('لا'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _bookingController.completeBooking(bookingId);
              },
              child: Text('نعم'),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, foregroundColor: Colors.white),
            ),
          ],
        );
      },
    );
  }
}
