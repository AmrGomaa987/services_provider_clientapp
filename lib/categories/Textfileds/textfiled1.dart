import 'package:flutter/material.dart';

class TextF1 extends StatelessWidget {
  TextF1(
    this.s,
    this.obscureText,
  );
  String? s;

  final bool obscureText;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        height: 55,
        child: TextField(
          style: TextStyle(fontSize: 13.0),
          obscureText: obscureText,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(30)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(30)),
            filled: true,
            labelText: s!,
            alignLabelWithHint: true,
          ),
        ),
      ),
    );
  }
}
