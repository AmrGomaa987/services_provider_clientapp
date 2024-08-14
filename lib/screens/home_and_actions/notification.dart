import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: NotificationScreen(),
  ));
}

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<bool> switchValues = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('اشعارات '),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // First Row
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Text Aligned to the Right
                Flexible(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'اشعارات عامه',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                SizedBox(width: 16), // Add space between text and button
                // Toggle Button on the Most Left
                Switch(
                  value: switchValues[0],
                  onChanged: (value) {
                    // Handle the toggle button state change
                    setState(() {
                      switchValues[0] = value;
                    });
                    print("Toggle Button Value: $value");
                  },
                ),
              ],
            ),
          ),

          // Second Row
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      ' صوت',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Switch(
                  value: switchValues[1],
                  onChanged: (value) {
                    setState(() {
                      switchValues[1] = value;
                    });
                    print("Toggle Button Value: $value");
                  },
                ),
              ],
            ),
          ),

          // Third Row
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      ' اهتزاز',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Switch(
                  value: switchValues[2],
                  onChanged: (value) {
                    setState(() {
                      switchValues[2] = value;
                    });
                    print("Toggle Button Value: $value");
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      ' عروض مميزه',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Switch(
                  value: switchValues[3],
                  onChanged: (value) {
                    setState(() {
                      switchValues[3] = value;
                    });
                    print("Toggle Button Value: $value");
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      ' خصومات',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Switch(
                  value: switchValues[4],
                  onChanged: (value) {
                    setState(() {
                      switchValues[4] = value;
                    });
                    print("Toggle Button Value: $value");
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      ' مدفوعات',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Switch(
                  value: switchValues[5],
                  onChanged: (value) {
                    setState(() {
                      switchValues[5] = value;
                    });
                    print("Toggle Button Value: $value");
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      ' كاش باك',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Switch(
                  value: switchValues[6],
                  onChanged: (value) {
                    setState(() {
                      switchValues[6] = value;
                    });
                    print("Toggle Button Value: $value");
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      ' تحديثات التطبيق',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Switch(
                  value: switchValues[7],
                  onChanged: (value) {
                    setState(() {
                      switchValues[7] = value;
                    });
                    print("Toggle Button Value: $value");
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
