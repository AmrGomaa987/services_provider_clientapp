import 'package:clientphase/noconn.dart';
import 'package:clientphase/oldapi/http_forget_pass/forget_password.dart';
import 'package:clientphase/oldapi/http_forget_pass/http_service_check_your_email.dart';
import 'package:clientphase/screens/forgetandresetpass/add_email_to_reset_pass.dart';
import 'package:clientphase/screens/forgetandresetpass/newpass.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class sendd extends StatelessWidget {
  sendd(this.email);
  String email;

  @override
  Widget build(BuildContext context) {
    return  StreamBuilder<ConnectivityResult>(
        stream: Connectivity().onConnectivityChanged,
        builder: (context, snapshot) {
          return snapshot.data==ConnectivityResult.none?
          const NoConnectionWidget()
          : 
    Scaffold(
      backgroundColor: Colors.white,
      appBar:AppBar(
    backgroundColor: Colors.white,
    title: const Text(
      "هل نسيت كلمة السر",
      style: TextStyle(color: Colors.black),
    ),
    elevation: 0,
    leading: IconButton(
      icon: Icon(Icons.arrow_back, color: Colors.black),
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) {
            return AddEmil(); // Replace AnotherPage with your target page
          },
        ));
      },
    ),
  ),
      body: ListView(
        children: [
          SizedBox(height: 150),
          sendnum(),
          SizedBox(height: 52),
          rowbox(email),
          SizedBox(height: 30),
          SizedBox(height: 120),
         
        ],
      ),
    );
         }); }
}


Center sendnum() {
  return Center(
      child: Text("قم بكتابة الرمز المكون من 6 ارقام",
          style: TextStyle(fontWeight: FontWeight.bold)));
}


class rowbox extends StatefulWidget {
  rowbox(this.email);
  final String email;

  @override
  State<rowbox> createState() => _rowboxState();
}

class _rowboxState extends State<rowbox> {
  final _codeContoller = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final HttpServiceForgetPassword httpService = HttpServiceForgetPassword();
  final HttpServiceCheckEmail httpServiceCheckEmail = HttpServiceCheckEmail();
  late String email;
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
        widget.email,
      );

      // Login successful, you can navigate to another screen or show a success message
      //Get.to(const HomeLayout());
      errorMessage = "";
      Fluttertoast.showToast(
        msg: "تحقق من بريدك الالكتروني",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      //Get.to(CheckEmail(email: _emailContoller.text,));

      print(' ناجحة!');
    } catch (e) {
      // Handle validation errors or network errors
      setState(() {
        errorMessage = 'خطأ: $e';
        if (errorMessage.contains('404')) {
          // Your code here
          errorMessage = "البريد الإلكتروني غير موجود!";
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

  void _checkEmail() async {
    // Reset error message and loading state
    setState(() {
      errorMessage = '';
      isLoading = true;
    });
    int code = int.parse(_codeContoller.text);
    print('code = $code');
    try {
      // Add your login logic here, e.g., make API call
      await httpServiceCheckEmail.checkEmail(
        _codeContoller.text,
      );

      // Login successful, you can navigate to another screen or show a success message
      //Get.to(const HomeLayout());
      errorMessage = "";
      Fluttertoast.showToast(
        msg: "رمز صالح",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      Get.to(newpass(email));

      print(' successful!');
    } catch (e) {
      // Handle validation errors or network errors
      setState(() {
        errorMessage = 'خطأ: $e';
        if (errorMessage.contains('422')) {
          // Your code here
          errorMessage = "يجب أن يكون رمز إعادة الضبط مكونًا من 6 أرقام!";
        } else if (errorMessage.contains('400')) {
          errorMessage = "إعادة تعيين الرمز غير صالح!";
        } else {
          errorMessage = "خطأ غير متوقع!";
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
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              65.0,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 10.0),
                    TextFormField(
                      controller: _codeContoller,
                      decoration: InputDecoration(
                        labelText: 'رمز التحقق',
                        labelStyle: TextStyle(
                          fontSize: 25.0,
                        ),
                        prefixIcon: Icon(
                          Icons.numbers,
                        ),
                        border: OutlineInputBorder(),
                      ),
                      textAlign: TextAlign.start,
                      keyboardType: TextInputType.number,
                      onFieldSubmitted: (value) {},
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'رمز التحقق مطلوب';
                        }
                        return null;
                      },
                    ),
                   
                    
                    SizedBox(
                      height: 50.0,
                    ),
                    Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            20.0,
                          ),
                          color: Color(0xFF7210ff),
                        ),
                        child: MaterialButton(
                          child: Text(
                            'استمر',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                            ),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              email = widget.email;
                              _checkEmail();
                            }
                          },
                        )),
                    SizedBox(
                      height: 10.0,
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                        onTap: () {
                            _forgetPassword();
                        },
                        child: Text(
                          '',
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
