import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:groovex/screens/home.dart';
import 'package:groovex/screens/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GrooveX',
      theme: ThemeData(
       appBarTheme: AppBarTheme(
         backgroundColor: Colors.transparent,
         elevation: 0,
       )
      ),
      home: HomePage()
    );
  }
}
