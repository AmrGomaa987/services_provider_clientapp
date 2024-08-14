import 'dart:async';

import 'package:clientphase/network/local/cach_helper.dart';
import 'package:clientphase/onboarding.dart';
import 'package:clientphase/screens/home_and_actions/home1.dart';
import 'package:clientphase/screens/letsin/letsyou.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool _initialized = true;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await CacheHelper.init();
    bool? onBoarding = CacheHelper.getBool(key: 'onBoarding');
    String? token = await CacheHelper.getData(key: 'token');
    print("before if token= $token");
    print("before if onboarding= $onBoarding");

    //Future.delayed(Duration(seconds: 5),
    Timer(const Duration(seconds: 3), () async {
      print("$onBoarding");
      if (onBoarding != null && onBoarding && token != null) {
        print("if $onBoarding");

        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const Home1(),
        ));
      } else if (onBoarding != null && token == null) {
        print("else if $onBoarding");

        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const Letsyou(),
        ));
      } else if (onBoarding == null) {
        print("else $onBoarding");

        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const onboarding_screen(),
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: EasySplashScreen(
      logoWidth: 100,
      logo: Image.asset(
        "assets/images/3.png",
        width: 1000,
        height: 700,
        fit: BoxFit.cover,
      ),
      title: const Text(
        "",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.white,
      showLoader: true,
      loadingText: const Text("...تحميل"),
      navigator: const onboarding_screen(),
    ));
  }
}
