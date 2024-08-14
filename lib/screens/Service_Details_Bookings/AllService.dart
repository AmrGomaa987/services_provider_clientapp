import 'package:clientphase/screens/Service_Details_Bookings/allservicesdata.dart';
import 'package:clientphase/screens/home_and_actions/home1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllService extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'جميع الخدمات',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
            onPressed: () {
              Get.to(Home1());
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
      ),
      
      body: Center(
        child: ListView(
          
          children: [AllServicesData()],
        ),
      ),
    );
  }
}
