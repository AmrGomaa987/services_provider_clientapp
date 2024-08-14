import 'package:clientphase/screens/forgetandresetpass/forget.dart';
import 'package:clientphase/screens/forgetandresetpass/newpass.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';



class Security extends StatefulWidget {
  @override
  _SecurityState createState() => _SecurityState();
}

class _SecurityState extends State<Security> {
  List<bool> switchValues = [false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('  الامان'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // First Row
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Text Aligned to the Right
                Flexible(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '  تذكرني',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                SizedBox(width: 16), // Add space between text and button
                // Toggle Button on the Most Left
                Switch(
                  value: switchValues[0],
                  onChanged: (value) {
                    // Handle the toggle button state change
                    setState(() {
                      switchValues[0] = value;
                    });
                    print("Toggle Button Value: $value");
                  },
                ),
              ],
            ),
          ),

          // Second Row
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '  بصمة اصبع ',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Switch(
                  value: switchValues[1],
                  onChanged: (value) {
                    setState(() {
                      switchValues[1] = value;
                    });
                    print("Toggle Button Value: $value");
                  },
                ),
              ],
            ),
          ),

          // Third Row
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '  بصمة وجه ',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Switch(
                  value: switchValues[2],
                  onChanged: (value) {
                    setState(() {
                      switchValues[2] = value;
                    });
                    print("Toggle Button Value: $value");
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: GestureDetector(
              onTap: () {
                //Get.to(newpass());
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF7210ff),
                  borderRadius: BorderRadius.circular(25),
                ),
                width: 300,
                height: 50,
                child: const Center(
                    child: Text(
                  "  تغير كلمة المرور",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
