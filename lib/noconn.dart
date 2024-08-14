import 'package:flutter/material.dart';

class NoConnectionWidget extends StatelessWidget {
  const NoConnectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                Icons.wifi_off,
                color: Colors.black,
                size: 50.0,
              ),
              SizedBox(height: 10.0),
              Text(
                "لا يوجد اتصال بالإنترنت",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  
                ),
              ),
              SizedBox(height: 5.0),
              Text(
                "الرجاء التحقق من اتصال الانترنت الخاص بك",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
