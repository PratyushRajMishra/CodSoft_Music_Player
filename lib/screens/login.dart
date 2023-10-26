import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:groovex/screens/Signup.dart';

import '../controllers/UIHelper.dart';
import '../models/UserModel.dart';
import 'home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void checkvalues() {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email == "" || password == "") {
      UIHelper.showAlertDialog(context, "Incomplete Data", "Please fill all the fields!");
    } else {
      logIn(email, password);
    }
  }

  void logIn(String email, String password) async {
    UserCredential? credential;

    UIHelper.showLoadingDialog(context, "Logging In..");

    try {
      credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (ex) {
      Navigator.pop(context);
      UIHelper.showAlertDialog(context, "An error occured", ex.message.toString());
    }

    if (credential != null) {
      String uid = credential.user!.uid;

      DocumentSnapshot userData =
      await FirebaseFirestore.instance.collection('users').doc(uid).get();
      UserModel userModel =
      UserModel.fromMap(userData.data() as Map<String, dynamic>);

      print("Log in Successfully!");
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context){
          return HomePage();
        }
        ),
      );
    }
  }

  void _showForgotPasswordDialog() {
    TextEditingController emailController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Forgot Password?"),
          content: TextField(
            controller: emailController,
            decoration: InputDecoration(
              hintText: "Enter your email",
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Reset Password"),
              onPressed: () async {
                String email = emailController.text.trim();

                if (email.isNotEmpty) {
                  try {
                    await FirebaseAuth.instance.sendPasswordResetEmail(
                      email: email,
                    );
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Please check your email to reset your password.",
                        ),
                        duration: Duration(seconds: 5), // Adjust the duration as needed
                      ),
                    );
                  } on FirebaseAuthException catch (ex) {
                    UIHelper.showAlertDialog(
                      context,
                      "An error occurred",
                      ex.message.toString(),
                    );
                  }
                } else {
                  UIHelper.showAlertDialog(
                    context,
                    "Incomplete Data",
                    "Please enter your email.",
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }



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
                    style: const TextStyle(color: Colors.white),
                    controller: emailController,
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
                    style: const TextStyle(color: Colors.white),
                    controller: passwordController,
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
                      onPressed: () {
                        _showForgotPasswordDialog();
                      },
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
                      onPressed: () {
                        checkvalues();
                      }),
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
