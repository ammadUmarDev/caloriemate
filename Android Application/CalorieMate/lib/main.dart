import 'package:calorie_mate/providers/general_provider.dart';
import 'package:calorie_mate/screens/authentication/LoginPage.dart';
import 'package:calorie_mate/screens/authentication/RegisterPage.dart';
import 'package:calorie_mate/screens/authentication/login_signup.dart';
import 'package:calorie_mate/screens/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'screens/authentication/login_signup.dart';
import 'screens/authentication/login_signup.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Provider.debugCheckInvalidValueType = null;
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //   statusBarColor: Colors.transparent, //or set color with: Color(0xFF0000FF)
  // ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<General_Provider>(create: (context) => General_Provider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: "Montserrat",
        ),
        initialRoute: LoginSignupScreen.id,
        routes: {
          RegisterPage.id: (context) => RegisterPage(),
          LoginPage.id: (context) => LoginPage(),
          LoginSignupScreen.id: (context) => LoginSignupScreen(),
          DashBoard.id: (context) => DashBoard(),
        },
      ),
    );
  }
}
