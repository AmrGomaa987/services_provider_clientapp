import 'dart:io';

import 'package:clientphase/onboarding.dart';
import 'package:clientphase/screens/letsin/createaccount.dart';
import 'package:clientphase/screens/letsin/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class Letsyou extends StatelessWidget {
  const Letsyou({super.key});

  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
      onWillPop: () async {
        if (Platform.isIOS) {
          exit(0);
        } else {
          SystemNavigator.pop();
        }
        return true;
      },
      child:
     Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Column(
            mainAxisAlignment:
                MainAxisAlignment.start, // Center vertically at the top
            children: [
              image(),
              Text(
                "دعنا ندخل",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              
              SizedBox(height: 16),
             // roww(),
              SizedBox(height: 16),
              ContainerButton(),
              SizedBox(height: 16),
              centersign(),
              SizedBox(height: 16),
            ],
          ),
        ],
      ),
    )
 ); }
}

Row roww() {
  return const Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Expanded(
        child: Divider(
          endIndent: 12,
          color: Color.fromARGB(255, 199, 197, 197),
          thickness: 1,
          indent: 35,
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(
          "أو",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ),
      Expanded(
        child: Divider(
          endIndent: 35,
          color: Color.fromARGB(255, 199, 197, 197),
          thickness: 1,
          indent: 12,
        ),
      ),
    ],
  );
}

class image extends StatelessWidget {
  const image({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 0),
        height: 190,
        width: 210,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/led.png"),
          ),
        ),
      ),
    );
  }
}

class centersign extends StatelessWidget {
  const centersign({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "ليس لديك حساب ؟  ",
            style: TextStyle(
                color: Color.fromARGB(255, 128, 126, 126), fontSize: 19),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> CreateAccount()));
              // Get.to(CreateAccount());
            },
            child: Text(
              "أشترك",
              style: TextStyle(
                  color: Color(0xFF7210ff),
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline),
            ),
          ),
        ],
      ),
    );
  }
}

class ContainerButton extends StatelessWidget {
  const ContainerButton({Key? key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: 400,
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(35),
        color: Color(0xFF7210ff),
      ),
      child: ElevatedButton(
        onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Login()));

          // Get.to(Login());
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        child: Text("تسجيل الدخول مع كلمة المرور",
            style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
      ),
    );
  }
}

