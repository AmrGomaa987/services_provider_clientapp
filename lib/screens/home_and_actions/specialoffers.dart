import 'package:clientphase/screens/forgetandresetpass/newpass.dart';
import 'package:clientphase/screens/home_and_actions/home1.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class special extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.to(Home1());
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "اذا قمت بحجز 10 خدمات سوف تحصل علي كوبون بخصم 20%",
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
