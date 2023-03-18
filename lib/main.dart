import 'package:cakery_admin_web_portal/authentication/login_screen.dart';
import 'package:cakery_admin_web_portal/main_screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future <void> main() async
{
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCgYevEBf92UoIqKIEIQhQuF0ZI7Q-arHc",
          authDomain: "cakery-app.firebaseapp.com",
          projectId: "cakery-app",
          storageBucket: "cakery-app.appspot.com",
          messagingSenderId: "239201472285",
          appId: "1:239201472285:web:fd115ea7571aa9d8ad1bf4"));
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
      home: FirebaseAuth.instance.currentUser == null ? const LoginScreen() : const HomeScreen(),
    );
  }
}
