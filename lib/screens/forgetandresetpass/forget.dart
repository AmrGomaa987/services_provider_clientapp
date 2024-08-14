import 'package:clientphase/screens/forgetandresetpass/add_email_to_reset_pass.dart';
import 'package:clientphase/screens/forgetandresetpass/sendpass.dart';
import 'package:clientphase/screens/letsin/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_utils/get_utils.dart';

class forget extends StatelessWidget {
   forget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
    backgroundColor: Colors.white,
    title: Text(
      "هل نسيت كلمة السر",
      style: TextStyle(color: Colors.black, fontSize: 20),
    ),
    elevation: 0,
    leading: IconButton(
      icon: Icon(Icons.arrow_back, color: Colors.black),
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) {
            return Login();
          },
        ));
      },
    ),
  ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        children: [
          Imagee(),
        SizedBox(height: 30),

          GestureDetector(
            onTap: () {
              Get.to(AddEmil());
            },
            child: cardtext(
                icon: Icons.email,
                t1: "عبر البريد الالكتروني :",
                t2: "and***ley@yourdomain.com"),
          ),
        
        ],
      ),
    );
  }
}



class cardtext extends StatelessWidget {
  const cardtext({
    super.key,
    required this.t1,
    required this.t2,
    required this.icon,
  });
  final IconData icon;
  final String t1, t2;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 26, vertical: 7),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
        side: const BorderSide(color: Colors.grey),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
        leading: Container(
          height: 100,
          width: 80,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color.fromARGB(255, 243, 239, 247),
          ),
          child: Center(
            child: Icon(icon, color: const Color(0xFF7210ff), size: 28),
          ),
        ),
        title: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(t1,
                    style: const TextStyle(fontSize: 14, color: Colors.grey)),
                const SizedBox(height: 5),
                Text(t2,
                    style: const TextStyle(
                        fontSize: 10,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Center Imagee() {
  return Center(
    child: Container(
      margin: EdgeInsets.only(top: 10),
      width: 260,
      height: 220,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/itled.png"), fit: BoxFit.cover),
        // shape: BoxShape.circle
      ),
    ),
  );
}

