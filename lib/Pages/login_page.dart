import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:karinderya_go/CommonWidgets/calert.dart';
import 'package:karinderya_go/CommonWidgets/cbutton.dart';
import 'package:karinderya_go/CommonWidgets/cfield.dart';
import 'package:karinderya_go/constant/rdesign.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final eController = TextEditingController();

  final pController = TextEditingController();

  // Sign IN
  void signIn() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(
            color: mainOrange,
          ),
        );
      },
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: eController.text, password: pController.text);
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      errorManager(e.code.toUpperCase());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              // LOGO
              const SizedBox(height: 50),
              Container(
                margin: const EdgeInsets.all(8.0),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Image(
                  image: AssetImage(
                    kLogoC,
                  ),
                  height: 200,
                  width: 200,
                ),
              ),
              // TextField Username
              const SizedBox(height: 30),
              CustomTextField(
                controller: eController,
                hintText: 'Email',
                obscureText: false,
              ),
              //TextField Password
              const SizedBox(height: 20),
              CustomTextField(
                controller: pController,
                hintText: 'Password',
                obscureText: true,
              ),
              const SizedBox(height: 20),
              // LoginButton
              CustomLoginButton(
                text: 'Sign In',
                onTap: signIn,
              ),
              //forgot password
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Forgot Password',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 120),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Not a Member?'),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      'Register now',
                      style: TextStyle(color: Color.fromARGB(255, 6, 112, 199)),
                    ),
                  )
                ],
              )
              //not SignIn?
            ]),
          ),
        ),
      ),
    );
  }

  void errorManager(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return CustomAlertDialog(
          alertText: message,
        );
      },
    );
  }
}
