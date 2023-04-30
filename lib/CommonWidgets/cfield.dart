import 'package:flutter/material.dart';
import 'package:karinderya_go/constant/rdesign.dart';

class CustomTextField extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final controller;
  final String hintText;
  final bool obscureText;

  const CustomTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: mainWhite),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: brightOrange),
          ),
          hintText: hintText,
        ),
        obscureText: obscureText,
      ),
    );
  }
}
