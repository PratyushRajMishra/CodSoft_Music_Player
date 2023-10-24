import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:groovex/screens/login.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
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
            Icons.arrow_back,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0, left: 0.0),
                    child: Text(
                      "Hello,\nRegister here!",
                      style: TextStyle(
                        color: Colors.grey.shade300,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height:20),
                Image.asset(
                  "assets/music_logo_dark.png",
                  width: 175,
                  height: 175,
                  fit: BoxFit.fitHeight,
                ),
                SizedBox(height:15),
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
                        'Confirm Password',
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.w500),
                      )),
                ),
                SizedBox(
                  height: 40,
                ),
                CupertinoButton(
                    child: Text(
                      'Sign up',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    color: Colors.blueGrey.shade500,
                    onPressed: () {}),

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
                    'Sign up with Google',
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
                          "Already member?  ",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Sign in',
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
