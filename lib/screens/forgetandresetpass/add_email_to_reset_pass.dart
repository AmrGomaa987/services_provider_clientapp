import 'package:clientphase/categories/Textfileds/textF2password.dart';
import 'package:clientphase/categories/Textfileds/textF2.dart';
import 'package:clientphase/noconn.dart';
import 'package:clientphase/oldapi/http_forget_pass/forget_password.dart';
import 'package:clientphase/screens/forgetandresetpass/forget.dart';
import 'package:clientphase/screens/forgetandresetpass/sendpass.dart';
import 'package:clientphase/screens/letsin/letsyou.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class AddEmil extends StatefulWidget {
  AddEmil({super.key});

  @override
  State<AddEmil> createState() => _AddEmilState();
}

class _AddEmilState extends State<AddEmil> {
  final _emailContoller = TextEditingController();

  final HttpServiceForgetPassword httpService = HttpServiceForgetPassword();

  bool isLoading = false;

  String errorMessage = '';
  void _forgetPassword() async {
    // Reset error message and loading state
    setState(() {
      errorMessage = '';
      isLoading = true;
    });

    try {
      // Add your login logic here, e.g., make API call
      await httpService.forgetPassword(
        _emailContoller.text,
      );

      // Login successful, you can navigate to another screen or show a success message
      //Get.to(const HomeLayout());
      errorMessage = "";
      Fluttertoast.showToast(
        msg: "البريد الالكتروني صالح",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      Get.to(sendd(
        _emailContoller.text,
      ));

      print(' successful!');
    } catch (e) {
      // Handle validation errors or network errors
      setState(() {
        errorMessage = 'خطأ: $e';
        if (errorMessage.contains('404')) {
          // Your code here
          errorMessage = "البريد الإلكتروني غير موجود!";
        } else {
          errorMessage = "  قم بكتابة بريدك الالكتروني";
        }

        Fluttertoast.showToast(
          msg: errorMessage,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      });
    } finally {
      // Update loading state
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  bool obscureText = true;
  bool obscure = true;
  Widget build(BuildContext context) {
    return SafeArea(
      child:  StreamBuilder<ConnectivityResult>(
        stream: Connectivity().onConnectivityChanged,
        builder: (context, snapshot) {
          return snapshot.data==ConnectivityResult.none?
          const NoConnectionWidget()
          : 
       Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return Letsyou();
                          },
                        ));
                      },
                      icon: const Icon(
                        Icons.arrow_forward,
                        weight: 12,
                      ))),
            ),
             Padding(
              padding: EdgeInsets.only(right: 20),
              child: Text(
                "قم بكتابة بريدك الالكتروني ",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24, // Adjusted font size to be smaller
                  fontWeight: FontWeight.w600, // Adjusted font weight for suitability
                ),
              ),
            ),
       SizedBox(height: 80,),
            //----------------------email-------------------------------------------
            Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30),
              child: TextField(
                style: TextStyle(fontSize: 12.0),
                decoration: InputDecoration(
                    labelText: "البريد الاكتروني",
                    prefixIcon: Icon(
                      Icons.email,
                      size: 20,
                    ), // Icon on the left
                    filled: true,
                    fillColor: Color.fromARGB(250, 250, 250, 255),
                    hintStyle: TextStyle(color: Colors.grey),
                    labelStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF7210ff),
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(20),
                    )
                    // Optional background color
                    ),
                controller: _emailContoller,
              ),
            ),
            //----------------------email-------------------------------------------

            const SizedBox(
              height: 20,
            ),
            //------------------------------textfiled pass-----------------------------------------

            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
              child: GestureDetector(
                onTap: () {
                  if (_emailContoller.text != null) {
                    _forgetPassword();
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF7210ff),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    width: 100,
                    height: 50,
                    child: const Center(
                        child: Text(
                      " تأكيد",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    )),
                  ),
                ),
              ),
            ),
          
          ],
        ),
      );
   }) );
  }
}
