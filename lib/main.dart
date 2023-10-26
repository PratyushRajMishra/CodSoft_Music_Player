import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:groovex/screens/home.dart';
import 'package:groovex/screens/login.dart';

import 'controllers/FirebaseHelper.dart';
import 'firebase_options.dart';
import 'models/UserModel.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  User? currentUser = FirebaseAuth.instance.currentUser;
  if(currentUser != null){
    //Not logged in
    UserModel? thisUserModel = await FirebaseHelper.getUserModelById(currentUser.uid);

    if(thisUserModel != null) {
      runApp(
          MyAppLoggedIn(userModel: thisUserModel, firebaseUser: currentUser));
    }
    else{
      runApp(const MyApp());
    }
  }
  else{
    //logged in
    runApp(const MyApp());
  }

  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class MyAppLoggedIn extends StatelessWidget {
  final UserModel userModel;
  final User firebaseUser;

  const MyAppLoggedIn({super.key, required this.userModel, required this.firebaseUser});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
