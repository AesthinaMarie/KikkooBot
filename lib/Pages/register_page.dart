import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:karinderya_go/CommonWidgets/calert.dart';
import 'package:karinderya_go/CommonWidgets/cbutton.dart';
import 'package:karinderya_go/CommonWidgets/cfield.dart';
import 'package:karinderya_go/constant/rdesign.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  _RegisterPageState() {
    orgtype = orgtypelist[0];
  }

  String? orgtype = "";
  List orgtypelist = ["Student", "Faculty", "Staff"];

  bool isPWD = false;
  final eController = TextEditingController();
  final pController = TextEditingController();
  final fullname = TextEditingController();
  final phoneNumber = TextEditingController();

  // Sign IN
  void signUp() async {
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
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: eController.text, password: pController.text);
      Navigator.pop(context);
      addUserDetails(fullname.text.trim(), eController.text.trim(),
          int.parse(phoneNumber.text.trim()), isPWD, orgtype.toString());
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      errorManager(e.code.toUpperCase());
    }
  }

  Future addUserDetails(
    String Fullname,
    String Email,
    int Number,
    bool pwd,
    String Organization,
  ) async {
    await FirebaseFirestore.instance.collection('Customer').add({
      "Fullname": Fullname,
      "Email": Email,
      "PhoneNumber": Number,
      "PWD": pwd,
      "Organization": Organization,
    });
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

              Container(
                margin: const EdgeInsets.all(8.0),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Image(
                  image: AssetImage(
                    kLogoC,
                  ),
                  height: 150,
                  width: 150,
                ),
              ),
              const SizedBox(height: 10),
              CustomTextField(
                controller: fullname,
                hintText: 'Full Name',
                obscureText: false,
              ),
              // TextField Username
              const SizedBox(height: 10),
              CustomTextField(
                controller: eController,
                hintText: 'Email',
                obscureText: false,
              ),
              //TextField Password
              const SizedBox(height: 10),
              CustomTextField(
                controller: pController,
                hintText: 'Password',
                obscureText: true,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                controller: phoneNumber,
                hintText: 'Phone Number',
                obscureText: false,
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: DropdownButtonFormField(
                    decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: mainWhite),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: mainOrange))),
                    value: orgtype,
                    items: orgtypelist.map((e) {
                      return DropdownMenuItem(child: Text(e), value: e);
                    }).toList(),
                    onChanged: (val) {
                      setState(() {
                        orgtype = val as String;
                      });
                    }),
              ),
              const SizedBox(height: 10),
              //CheckList
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                        activeColor: mainOrange,
                        value: isPWD,
                        onChanged: (newbool) {
                          setState(() {
                            isPWD = newbool!;
                          });
                        }),
                    Text('Are you a PWD?'),
                  ],
                ),
              ),
              // LoginButton
              CustomLoginButton(
                text: 'Sign Up',
                onTap: signUp,
              ),

              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an Account?'),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      'Login now',
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
