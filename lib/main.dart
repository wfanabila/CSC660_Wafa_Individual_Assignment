import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'wrapper.dart';
import 'package:get/get.dart';


void main() async{
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        // Remove the debug banner
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorSchemeSeed: const Color(0xFFFFCAA3),
        ),
        home: const Wrapper());
  }
}