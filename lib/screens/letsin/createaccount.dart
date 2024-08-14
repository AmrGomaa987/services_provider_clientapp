import 'package:clientphase/categories/Textfileds/textF2.dart';
import 'package:clientphase/categories/Textfileds/textF2password.dart';
import 'package:clientphase/noconn.dart';
import 'package:clientphase/oldapi/http_serviceregistration.dart';
import 'package:clientphase/screens/letsin/letsyou.dart';
import 'package:clientphase/screens/letsin/login.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final HttpServiceRegistration httpService = HttpServiceRegistration();
  bool isLoading = false;
  String errorMessage = '';

  void _registerUser() async {
    setState(() {
      errorMessage = '';
      isLoading = true; // Set isLoading to true initially
    });

    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        confirmPasswordController.text.isEmpty ||
        passwordController.text.isEmpty) {
      Fluttertoast.showToast(
        msg: 'برجاء ادخال البيانات كاملة',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      setState(() {
        isLoading = false; // Set isLoading back to false
      });
      return;
    } else if (!emailController.text.toLowerCase().endsWith('.com')) {
      Fluttertoast.showToast(
        msg: 'البريد الإلكتروني غير صحيح ',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      setState(() {
        isLoading = false; // Set isLoading back to false
      });
      return;
    } else if (passwordController.text != confirmPasswordController.text) {
      Fluttertoast.showToast(
        msg: "كلمة السر غير متطابقتان",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      setState(() {
        isLoading = false; // Set isLoading back to false
      });
      return;
    } else if (nameController.text.length <= 3) {
      Fluttertoast.showToast(
        msg: "يجب ان يكون اسم المستخدم اكثر من 3 حروف",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      setState(() {
        isLoading = false; // Set isLoading back to false
      });
      return;
    } else if (passwordController.text.length < 8 ||
        confirmPasswordController.text.length < 8) {
      Fluttertoast.showToast(
        msg: "كلمة يجب تكون اكثر من 8 حروف او ارقام",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      setState(() {
        isLoading = false; // Set isLoading back to false
      });
      return;
    } else {
      try {
        // Attempt to register the user
        await httpService.registerUser(
          nameController.text,
          emailController.text,
          passwordController.text,
          confirmPasswordController.text,
        );
        Fluttertoast.showToast(
          msg: "نجح التسجيل!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        Get.to(Login());
      } catch (e) {
        // Handle registration error
        // Check if the error message contains indication of email already in use
        if (e.toString().toLowerCase().contains('422')) {
          Fluttertoast.showToast(
            msg: 'الايميل موجود بالفعل',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 5,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        } else {
          // For other errors, show the error message
          Fluttertoast.showToast(
            msg: "خطأ في التسجيل: $e",
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
          isLoading = false; // Set isLoading back to false
        });
      }
    }
  }

  @override
  bool obscureText = true;
  bool obscure = true;
  Widget build(BuildContext context) {
    return  StreamBuilder<ConnectivityResult>(
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
                    icon: Icon(
                      Icons.arrow_forward,
                      weight: 12,
                    ))),
          ),
         Padding(
              padding: EdgeInsets.only(right: 20),
              child: Text(
                " انشئ حسابك الجديد",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24, // Adjusted font size to be smaller
                  fontWeight: FontWeight.w600, // Adjusted font weight for suitability
                ),
              ),
            ),
       SizedBox(height: 40,),

          //-------------------------------------textfiled name------------------------------------------------
          Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30),
            child: TextField(
              style: TextStyle(fontSize: 12.0),
              decoration: InputDecoration(
                  labelText: "اسم المستخدم",
                  prefixIcon: Icon(
                    Icons.verified_user,
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
              controller: nameController,
            ),
          ),
          //-------------------------------------textfiled name------------------------------------------------

          SizedBox(
            height: 20,
          ),
          //-------------------------------------textfiled email------------------------------------------------

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
              controller: emailController,
            ),
          ),
          //-------------------------------------textfiled email------------------------------------------------

          SizedBox(
            height: 20,
          ),
          //-------------------------pass-----------------------------------------
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
              controller: passwordController,
            ),
          ),
          //-------------------------pass-----------------------------------------

          SizedBox(
            height: 20,
          ),
          //-------------------------conferm pass-----------------------------------------

          Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30),
            child: TextField(
                style: TextStyle(fontSize: 12.0),
                obscureText: obscure ? obscureText : false,
                // Use widget.obscure to determine if password should be obscured
                decoration: InputDecoration(
                  labelText: " تأكيد كلمةالمرور ",
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
                controller: confirmPasswordController),
          ),
          //-------------------------conferm pass-----------------------------------------

          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
            child: GestureDetector(
              onTap: () {
                isLoading ? null : _registerUser();
              },
              child: Padding(
                padding:  EdgeInsets.only(left: 25, right: 25),
                child: Container(
                  width: 100,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color(0xFF7210ff),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      if (!isLoading)
                        Text(
                          "انشاء حساب",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      if (isLoading)
                        CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          SizedBox(
            height: 20,
          ),
      
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "هل لديك حساب بالفعل؟",
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                   onTap: () {
                   Navigator.pushAndRemoveUntil(context, 
                   MaterialPageRoute(builder: (context)=>Login())
                   , (route)=>false);
                  },
                  child: Text(
                    "سجل دخول",
                    style: TextStyle(
                        color: Color(0xFF7210ff), fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
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
    );
         }); }
}
