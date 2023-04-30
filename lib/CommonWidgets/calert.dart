import 'package:flutter/material.dart';
import 'package:karinderya_go/constant/rdesign.dart';

class CustomAlertDialog extends StatelessWidget {
  final String alertText;
  const CustomAlertDialog({super.key, required this.alertText});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: mainOrange,
      title: Text(
        alertText,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
