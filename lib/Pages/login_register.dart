import 'package:flutter/material.dart';
import 'package:karinderya_go/Pages/login_page.dart';
import 'package:karinderya_go/Pages/register_page.dart';

class LorRPage extends StatefulWidget {
  const LorRPage({super.key});

  @override
  State<LorRPage> createState() => _LorRPageState();
}

class _LorRPageState extends State<LorRPage> {
  bool showLoginPage = true;

  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(
        onTap: togglePages,
      );
    } else {
      return RegisterPage(onTap: togglePages);
    }
  }
}
