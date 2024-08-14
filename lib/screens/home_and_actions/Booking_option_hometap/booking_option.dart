import 'dart:io';

import 'package:clientphase/noconn.dart';
import 'package:clientphase/screens/home_and_actions/Booking_option_hometap/accepted.dart';
import 'package:clientphase/screens/home_and_actions/Booking_option_hometap/cancel.dart';
import 'package:clientphase/screens/home_and_actions/Booking_option_hometap/clinetbooking.dart';
import 'package:clientphase/screens/home_and_actions/Booking_option_hometap/compliteBooking.dart';
import 'package:clientphase/screens/home_and_actions/Booking_option_hometap/rijict.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BookingOptionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (Platform.isIOS) {
          exit(0);
        } else {
          SystemNavigator.pop();
        }
        return true;
      },
      child: DefaultTabController(
        length: 5,
        child: StreamBuilder<ConnectivityResult>(
          stream: Connectivity().onConnectivityChanged,
          builder: (context, snapshot) {
            return snapshot.data == ConnectivityResult.none
                ? const NoConnectionWidget()
                : Scaffold(
                    appBar: AppBar(
                      title: Text('خيارات الحجز'),
                      leading: Container(),
                      bottom: TabBar(
                        tabs: [
                          Tab(text: 'معلق'),
                          Tab(text: 'مكتمل'),
                          Tab(text: 'مؤكد'),
                          Tab(text: 'رفض'),
                          Tab(text: 'ملغى'),
                        ],
                      ),
                    ),
                    body: TabBarView(
                      children: [
                        BookingTap(),
                        CompleteBookingScreen(),
                        acceptedTab(),
                        RijictBookingScreen(),
                        CancelBookingScreen(),
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }
}
