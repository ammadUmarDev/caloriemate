import 'package:flutter/material.dart';
import 'package:calorie_mate/onboarding/onboarding_screen.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calorie Mate',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'ProximaNova',
      ),
      home: OnBoardingScreen(),
    );
  }
}
