import 'package:flutter/material.dart';

class TextF2Pass extends StatefulWidget {
  TextF2Pass(this.hint, this.label, this.obscure ,this.controller, {this.icon});
  String? label;
  String? hint;

  final bool obscure;
  final Icon? icon;
  TextEditingController controller;
  
  @override
  State<TextF2Pass> createState() => _TextF2PassState();
}

class _TextF2PassState extends State<TextF2Pass> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30.0, right: 30),
      child: TextField(
        style: TextStyle(fontSize: 12.0),
        obscureText: widget.obscure ? obscureText : false,
        // Use widget.obscure to determine if password should be obscured
        controller:widget.controller ,
        decoration: InputDecoration(
          labelText: widget.label,
          hintText: widget.hint,
          prefixIcon: widget.icon, // Icon on the left
          suffixIcon: IconButton(
            icon: Icon(
              obscureText ? Icons.visibility_off : Icons.visibility,
              color: Colors.black,
            ),
            onPressed: () {
              setState(() {
                obscureText = !obscureText;
              });
            },
          ),
          fillColor: const Color.fromARGB(250, 250, 250, 255),
          filled: true,
          hintStyle: TextStyle(color: Colors.grey),
          labelStyle: TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderSide: BorderSide.none, // Hide the border side
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.purple,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none, // Hide the border side
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
