import 'package:flutter/material.dart';

class IntroPage3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Column(
            mainAxisAlignment:
                MainAxisAlignment.start, // Center vertically at the top
            children: [
              image(),
              Text(
                "دعونا نجعل بعض التغييرات الرائعة في حياتك",
                style: TextStyle(
                  fontSize: 15,
                ),
              )
            ],
          ),
        ],
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
        margin: const EdgeInsets.only(top: 30),
        height: 500,
        width: 500,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/img3.png"),
          ),
        ),
      ),
    );
  }
}
