import 'package:flutter/material.dart';

class InputTextField extends StatelessWidget {
  const InputTextField({
    Key? key,
    required this.autoFocus,
    required this.enable,
    required this.hint,
    required this.keyBoardType,
    required this.myController,
    required this.obscureText,
  }) : super(key: key);

  final TextEditingController myController;
  final TextInputType keyBoardType;
  final String hint;
  final bool obscureText;
  final bool enable;
  final bool autoFocus;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: TextFormField(
        controller: myController,
        obscureText: obscureText,
        keyboardType: keyBoardType,
        cursorColor: Colors.black,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(height: 0, fontSize: 19),
        decoration: InputDecoration(
          hintText: hint,
          enabled: enable,
          contentPadding: const EdgeInsets.all(20),
          hintStyle: Theme.of(context).textTheme.titleMedium!.copyWith(height: 0, color: Colors.black.withOpacity(0.8)),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
        ),
      ),
    );
  }
}



class DoubleInputTextField extends StatelessWidget {
  const DoubleInputTextField({
    Key? key,
    required this.autoFocus1,
    required this.autoFocus2,
    required this.enable1,
    required this.enable2,
    required this.hint1,
    required this.hint2,
    required this.keyBoardType1,
    required this.keyBoardType2,
    required this.myController1,
    required this.myController2,
    required this.obscureText1,
    required this.obscureText2,
  }) : super(key: key);

  final TextEditingController myController1;
  final TextEditingController myController2;
  final TextInputType keyBoardType1;
  final TextInputType keyBoardType2;
  final String hint1;
  final String hint2;
  final bool obscureText1;
  final bool obscureText2;
  final bool enable1;
  final bool enable2;
  final bool autoFocus1;
  final bool autoFocus2;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InputTextField(
          autoFocus: autoFocus1,
          enable: enable1,
          hint: hint1,
          keyBoardType: keyBoardType1,
          myController: myController1,
          obscureText: obscureText1,
        ),
        InputTextField(
          autoFocus: autoFocus2,
          enable: enable2,
          hint: hint2,
          keyBoardType: keyBoardType2,
          myController: myController2,
          obscureText: obscureText2,
        ),
      ],
    );
  }
}