import 'package:clientphase/categories/Textfileds/textF2password.dart';
import 'package:clientphase/noconn.dart';
import 'package:clientphase/oldapi/http_forget_pass/http_service_reset_password.dart';
import 'package:clientphase/screens/home_and_actions/home1.dart';
import 'package:clientphase/screens/letsin/login.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class newpass extends StatefulWidget {
  newpass(this.email);
  final String email;

  @override
  State<newpass> createState() => _newpassState();
}

class _newpassState extends State<newpass> {
  TextEditingController passwordcontroler = TextEditingController();

  TextEditingController confermpasswordcontroler = TextEditingController();
final HttpServiceResetPassword httpService = HttpServiceResetPassword();
  bool isLoading = false;

  String errorMessage = '';
  void _resetPassword() async {
    // Reset error message and loading state
    setState(() {
      errorMessage = '';
      isLoading = true;
    });

    try {

      print('from api email = ${widget.email}');
      print('from api password = ${passwordcontroler.text}');
      print('from api passwordConfirm = ${confermpasswordcontroler.text}');
      // Add your login logic here, e.g., make API call
      await httpService.resetPassword(
        passwordcontroler.text,
        confermpasswordcontroler.text,
        widget.email,
      );

      // Login successful, you can navigate to another screen or show a success message
      //Get.to(const HomeLayout());
      errorMessage = "";
      Fluttertoast.showToast(
        msg: "تمت إعادة التعيين بنجاح",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      Get.to(Login());

      print(' successful!');
    } catch (e) {
      // Handle validation errors or network errors
      setState(() {
        
        errorMessage = 'خطأ: $e';
        if(passwordcontroler.text.isEmpty ||confermpasswordcontroler.text.isEmpty ){
            errorMessage =" يجب تعبئة جميع الحقول";
        }
        else if(passwordcontroler.text != confermpasswordcontroler.text){
          errorMessage =" كلمة المرور غير متطابقتان";
        }
       else if (errorMessage.contains('404')) {
          // Your code here
          errorMessage ="البريد الإلكتروني غير موجود!";
        }else if (errorMessage.contains('400')) {
          // Your code here
          errorMessage ="انتهت صلاحية الرمز!";
        }
        else if (errorMessage.contains('422')) {
          // Your code here
          errorMessage ="خطأ في كلمة المرور!";
        }
        else{
          errorMessage ="خطأ غير متوقع!";
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
    return  StreamBuilder<ConnectivityResult>(
        stream: Connectivity().onConnectivityChanged,
        builder: (context, snapshot) {
          return snapshot.data==ConnectivityResult.none?
          const NoConnectionWidget()
          : 
    Scaffold(
      backgroundColor: Colors.white,
      appBar: bAppBar(),
      body: ListView(
        children: [
          image(),
          textt(),
          SizedBox(height: 30),
          TextF2Pass("", "", true,passwordcontroler,
              icon: Icon(
                Icons.lock,
                color: Colors.black,
              )),
          SizedBox(height: 18),
          TextF2Pass("", "", true,confermpasswordcontroler,
              icon: Icon(
                Icons.lock,
                color: Colors.black,
              )),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child:Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0,),
                            color: const Color(0xFF7210ff),
                          ),
                          child: MaterialButton(

                            child: const Text(
                              'إعادة تعيين',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                              ),
                            ),

                            onPressed: (){
                              _resetPassword();

                            },)), 
          ),
        ],
      ),
    );
          });  }
}

class ContainerButton extends StatelessWidget {
   ContainerButton({Key? key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(35),
        color: const Color(0xFF7210ff),
      ),
      child: ElevatedButton(
        onPressed: () {
          Get.to(Login());
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                return Home1();
              },
            ));
          },
          child: Text("أستمر",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}

class textt extends StatelessWidget {
  const textt({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 15.0),
      child: Text(
        "قم بإنشاء كلمة المرور الجديدة الخاصة بك   ",
        style: TextStyle(fontSize: 21),
      ),
    );
  }
}

class image extends StatelessWidget {
  const image({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 300,
        width: 350,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/new.png"),
          ),
        ),
      ),
    );
  }
}

AppBar bAppBar() {
  return AppBar(
    backgroundColor: Colors.white,
    title: const Text(
      "إنشاء كلمة مرور جديدة ",
      style: TextStyle(color: Colors.black, fontSize: 20),
    ),
    elevation: 0,
  );
}
