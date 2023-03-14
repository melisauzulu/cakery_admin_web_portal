import 'package:cakery_admin_web_portal/authentication/login_screen.dart';
import 'package:cakery_admin_web_portal/main_screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future <void> main() async
{
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "your info",
          authDomain: "your info",
          projectId: "your info",
          storageBucket: "your info",
          messagingSenderId: "your info",
          appId: "your info"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cakery Admin Web Portal',
      theme: ThemeData(

        primarySwatch: Colors.pink,
      ),
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
    );
  }
}
