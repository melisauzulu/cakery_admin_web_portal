import 'package:cakery_admin_web_portal/main_screens/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

// primary -> background color değişimi


class _LoginScreenState extends State<LoginScreen> {

  String adminEmail = "";
  String adminPassword = "";

  allowAdminToLogin() async
  {
    //we call this method when admin clicks on login button

    SnackBar snackBar = const SnackBar(
      content: Text(
        "Checking Credientials, Please Wait..." ,
        style: TextStyle (
          fontSize: 36,
          color: Colors.black,
        ),
      ),
      backgroundColor: Colors.pinkAccent,
      duration: Duration(seconds: 6),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    //checks if the email and password are correct via authentication
    User? currentAdmin;
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: adminEmail,
        password: adminPassword,
    ).then((fAuth)
    {
      //in case of success
      //get that admin and assign it to the current admin
      currentAdmin = fAuth.user;
    }).catchError((onError)
    {
      //in case of error
      //display error message
      final snackBar = SnackBar(
          content: Text(
            "Error Occured: " + onError.toString(),
            style: const TextStyle (
              fontSize: 36,
              color: Colors.black,
            ),
          ),
        backgroundColor: Colors.pinkAccent,
        duration: const Duration(seconds: 5),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });

    //if admin is authenticated successfully
    if(currentAdmin != null) {
      //check if that admin record also exists in the admins collection in firestore database
      await FirebaseFirestore.instance
          .collection("admins")
          .doc(currentAdmin!.uid)
          .get().then((snap)
      {
        if(snap.exists)
        //if admin exists in firestore
        {
          //allow admin to home screen
          Navigator.push(context, MaterialPageRoute(builder: (c)=> const HomeScreen()));
          
        }
        else
        //if record does not exists
        {
          SnackBar snackBar = const SnackBar(
            content: Text(
              "No Admin Record Found" ,
              style: TextStyle (
                fontSize: 36,
                color: Colors.black,
              ),
            ),
            backgroundColor: Colors.pinkAccent,
            duration: Duration(seconds: 6),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);

        }
      });
    }

  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.red.shade50,
      body: Stack(
        children: [
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * .5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //image/logo
                  Image.asset(
                    "images/admindeneme.jpg"

                  ),

                  const SizedBox(height: 30,),

                  //email text field
                  TextField(
                    onChanged: (value) {
                      adminEmail = value;
                    },
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                    decoration: InputDecoration(
                      //const koyunca input decorationa yine hata alıyorum
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 2,
                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.pink.shade100,
                          width: 2,
                        )
                      ),
                      hintText: "Email",
                      hintStyle: TextStyle(color: Colors.black54),
                      icon: Icon(
                        Icons.email_outlined,
                        color: Colors.black,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10,),

                  //password text field
                  TextField(
                    onChanged: (value) {
                      adminPassword = value;
                    },
                    obscureText: true,
                    //text is in doted form

                    style: const TextStyle(fontSize: 16, color: Colors.black),
                    decoration: InputDecoration(
                      //const koyunca input decorationa yine hata alıyorum
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 2,
                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.pink.shade100,
                            width: 2,
                          )
                      ),
                      hintText: "Password",
                      hintStyle: TextStyle(color: Colors.black54),
                      icon: Icon(
                        Icons.admin_panel_settings_outlined,
                        color: Colors.black,
                      ),
                    ),
                  ),

                  const SizedBox(height: 30,),

                  //login button
                  ElevatedButton(
                    onPressed: ()
                    {

                      allowAdminToLogin();

                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 100, vertical: 20)),
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.pink.shade700),
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.pink.shade900),
                    ),
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 2,
                        fontSize: 16,
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
