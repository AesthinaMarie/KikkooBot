import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:karinderya_go/Pages/login_page.dart';
import 'package:karinderya_go/backend/auth_page.dart';
import 'package:karinderya_go/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'KarinderyaGo',
      home: AuthPage(),
    );
  }
}
