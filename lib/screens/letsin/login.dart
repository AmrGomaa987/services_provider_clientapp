import 'dart:io';

import 'package:clientphase/categories/Textfileds/textF2password.dart';
import 'package:clientphase/categories/Textfileds/textF2.dart';
import 'package:clientphase/controllers/profile_controller.dart';
import 'package:clientphase/noconn.dart';
import 'package:clientphase/oldapi/http_service_login.dart';
import 'package:clientphase/screens/forgetandresetpass/forget.dart';
import 'package:clientphase/screens/home_and_actions/home1.dart';
import 'package:clientphase/screens/letsin/createaccount.dart';
import 'package:clientphase/screens/letsin/letsyou.dart';
import 'package:clientphase/services/api/profile_api.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class Login extends StatefulWidget {
  Login({super.key});
  final profileApi = ProfileApi();

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _emailContoller = TextEditingController();
  final _passwordContoller = TextEditingController();
  final HttpServiceLogin httpService = HttpServiceLogin();
  final profileApi = ProfileApi();
  late ProfileController profileController;
  bool isLoading = false;
  late Future<void> _futureprofile;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    profileController = Get.put(ProfileController());
    _futureprofile = _futureeprofile();
  }

  Future<void> _futureeprofile() async {
    try {
      await profileController.fetchProfile();
    } catch (e) {
      print(e);
    }
  }

 void _loginUser() async {
  setState(() {
    errorMessage = '';
    isLoading = true;
  });

  try {
    // Attempt to log in the user
    await httpService.loginUser(
      _emailContoller.text,
      _passwordContoller.text,
    );

    // Fetch user profile if login is successful
    await profileController.fetchProfile();

    // Navigate to the Home screen
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => Home1()),
    );

    print('Login successful!');
  } catch (e) {
    setState(() {
      errorMessage = 'خطأ: $e';
    });

    // Display error messages based on the provided email and password
    String emailErrorMessage = 'البريد الإلكتروني غير صحيح ';
    String passwordErrorMessage = "كلمة السر غير صحيحة";
    
    // Fetch the profile data only if the profile is available
    String profileEmail = profileController.profileData.value?.email ?? '';
      if (_emailContoller.text.isEmpty || _passwordContoller.text.isEmpty ) {
      Fluttertoast.showToast(
        msg: 'برجاء اكمال الحقول',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } 
    // Check if the entered email matches the profile email
    else if (_emailContoller.text != profileEmail) {
      Fluttertoast.showToast(
        msg: emailErrorMessage,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } else {
      Fluttertoast.showToast(
        msg: passwordErrorMessage,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  } finally {
    setState(() {
      isLoading = false;
    });
  }
}

  @override
  bool obscureText = true;
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child:  StreamBuilder<ConnectivityResult>(
        stream: Connectivity().onConnectivityChanged,
        builder: (context, snapshot) {
          print('snapshot data ${snapshot.data}');
          return snapshot.data==ConnectivityResult.none?
          const NoConnectionWidget()
          : 
       Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Padding(
                //   padding: const EdgeInsets.only(top: 20),
                //   child: Container(
                //       alignment: Alignment.topLeft,
                //       // child: IconButton(
                //       //     onPressed: () {
                //       //       Navigator.of(context).push(MaterialPageRoute(
                //       //         builder: (context) {
                //       //           return Letsyou();
                //       //         },
                //       //       ));
                //       //     },
                //       //     icon: const Icon(
                //       //       Icons.arrow_forward,
                //       //       weight: 12,
                //       //     ))
                //           ),
                // ),
              Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Text(
                    "سجل الدخول الي حسابك",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24, // Adjusted font size to be smaller
                      fontWeight: FontWeight.w600, // Adjusted font weight for suitability
                    ),
                  ),
                ),
                   SizedBox(height: 30,),
                
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
                  padding: const EdgeInsets.only(left: 30.0, right: 30),
                  child: TextField(
                    style: TextStyle(fontSize: 12.0),
                    obscureText: obscure ? obscureText : false,
                    // Use widget.obscure to determine if password should be obscured
                    decoration: InputDecoration(
                      labelText: "كلمة المرور",
                      prefixIcon: Icon(
                        Icons.lock,
                        size: 20,
                      ), // Icon on the left
                      suffixIcon: IconButton(
                        icon: Icon(
                          obscureText ? Icons.visibility_off : Icons.visibility,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          setState(() {
                            obscureText = !obscureText;
                          });
                        },
                      ),
                      fillColor: const Color.fromARGB(250, 250, 250, 255),
                      filled: true,
                      hintStyle: TextStyle(color: Colors.grey),
                      labelStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none, // Hide the border side
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF7210ff),
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none, // Hide the border side
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    //controller: passwordController,
                    controller: _passwordContoller,
                  ),
                ),
                //------------------------------textfiled pass-----------------------------------------
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
                  child: GestureDetector(
                onTap: () {
                  isLoading ? null : _loginUser();
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width, // Set width to screen width
                decoration: BoxDecoration(
                  color: Color(0xFF7210ff),
                  borderRadius: BorderRadius.circular(25),
                ),
                height: 50,
                child: Center(
                  child: Text(
                    " تسجيل الدخول",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
              if (isLoading)
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
            ],
                  ),
                ),
                  ),
                ),
                
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return forget();
                      },
                    ));
                  },
                  child: const Center(
                    child: Text(
                      " هل نسيت كلمة المرور",
                      style: TextStyle(
                          color: Color(0xFF7210ff), fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
               SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "ليس لديك حساب ؟",
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(CreateAccount());
                        },
                        child: Text(
                          " انشاء حساب",
                          style: TextStyle(
                              color: Color(0xFF7210ff),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                if (errorMessage.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      errorMessage,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
       }) ); }
}
