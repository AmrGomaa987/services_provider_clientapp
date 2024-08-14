import 'package:flutter/material.dart';

class TextF2 extends StatefulWidget {
  TextF2(this.hint, this.lable, this.obsecur, {this.icon});
  String? lable;
  String? hint;

  final bool obsecur;
  final Icon? icon;
  @override
  State<TextF2> createState() => _TextF2State();
}

class _TextF2State extends State<TextF2> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30.0, right: 30),
      child: TextField(
        style: TextStyle(fontSize: 12.0),
        obscureText: widget.obsecur,
        decoration: InputDecoration(
            labelText: widget.lable,
            hintText: widget.hint,
            prefixIcon: widget.icon, // Icon on the left
            filled: true,
            fillColor: Color.fromARGB(250, 250, 250, 255),
            hintStyle: TextStyle(color: Colors.grey),
            labelStyle: TextStyle(color: Colors.grey),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.purple,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(20),
            )
            // Optional background color
            ),
       
        
      ),
    );
  }
}
