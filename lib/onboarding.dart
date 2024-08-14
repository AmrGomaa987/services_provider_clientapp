import 'package:clientphase/into_screen/intro_page_1.dart';
import 'package:clientphase/into_screen/intro_page_2.dart';
import 'package:clientphase/into_screen/intro_page_3.dart';
import 'package:clientphase/network/local/cach_helper.dart';
import 'package:clientphase/screens/home_and_actions/home1.dart';
import 'package:clientphase/screens/letsin/letsyou.dart';
import 'package:clientphase/screens/letsin/login.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class onboarding_screen extends StatefulWidget {
  const onboarding_screen({Key? key}) : super(key: key);
  @override
  Boardingg createState() => Boardingg();
}

class Boardingg extends State<onboarding_screen> {
  PageController _controller = PageController();

  //keep track of if we are on last page or not
  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == 2);
              });
            },
            children: [
              IntroPage1(),
              IntroPage2(),
              IntroPage3(),
            ],
          ),
          Container(
            alignment: Alignment(0, 0.75),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                    onTap: () {
                      _controller.jumpToPage(2);
                      CacheHelper.saveData(key: 'onBoarding', value: true)
                          .then((value) {
                        print('value when Save OnBoarding');
                        if (value) {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => Letsyou()));
                        }
                      });
                    },
                    child: Text(
                      'تخطي',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                SmoothPageIndicator(controller: _controller, count: 3),
                onLastPage
                    ? GestureDetector(
                        onTap: () async {
                          await CacheHelper.init();

                          CacheHelper.saveData(key: 'onBoarding', value: true)
                              .then((value) {
                            print('value when Save OnBoarding');
                            if (value) {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => Letsyou()));
                            }
                          });
                        },
                        child: Text(
                          'تم',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ))
                    : GestureDetector(
                        onTap: () {
                          _controller.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeIn,
                          );
                        },
                        child: Text(
                          'التالي',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
