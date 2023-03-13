import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}




class _LoginScreenState extends State<LoginScreen> {

  String adminEmail = "";
  String adminPassword = "";

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
                    onPressed: () {

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
