import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:groovex/screens/Signup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.black,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.close_rounded,
                size: 30,
              )),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 0),
              child: Column(
                children: [
                  Image.asset(
                    "assets/music_logo_dark.png",
                    width: 175,
                    height: 175,
                    fit: BoxFit.fitHeight,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    "Welcome back you've been missed!",
                    style: TextStyle(color: Colors.grey.shade300, fontSize: 16),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: Colors.grey,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.0),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 1.0),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        label: Text(
                          'Email',
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.w500),
                        )),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.lock_outline,
                          color: Colors.grey,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.0),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 1.0),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        label: Text(
                          'Password',
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.w500),
                        )),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: Colors
                              .amber.shade900, // Customize the color as needed
                        ),
                      ),
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  CupertinoButton(
                      child: Text(
                        'Sign in',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      color: Colors.blueGrey.shade500,
                      onPressed: () {}),
                  SizedBox(
                    height: 35,
                  ),
                  Text(
                    '-------------------- or continue with -------------------',
                    style: TextStyle(color: Colors.grey),
                  ),

                  SizedBox(height: 30,),
                  OutlinedButton.icon(
                    style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all(Colors.white70)),
                    onPressed: () {},
                    icon: Container(
                      height: 25,
                        decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(16)),
                        child: Image.asset('assets/google_logo.png', height: 20,)),
                    label: Text(
                      'Sign in with Google',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height:50,),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Not a member?  ",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(
                                    () => SignupPage(),
                                transition: Transition.rightToLeft, // Use a Cupertino-style transition
                                duration: Duration(milliseconds: 400), // Adjust the duration as needed
                              );
                            },
                            child: Text('Register now',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
       );
  }
}
