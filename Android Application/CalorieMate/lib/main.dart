import 'package:calorie_mate/constants.dart';
import 'package:calorie_mate/providers/general_provider.dart';

import 'package:calorie_mate/screens/authentication/login_signup.dart';
import 'package:calorie_mate/screens/dashboard/calorie_predictor/calorie_predictor.dart';
import 'package:calorie_mate/screens/dashboard/calorie_predictor/calorie_results.dart';
import 'package:calorie_mate/screens/dashboard/calorie_predictor/loading.dart';
import 'package:calorie_mate/screens/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'constants.dart';

import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

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
          LoginSignupScreen.id: (context) => LoginSignupScreen(),
          LoginSignupScreen.id: (context) => LoginSignupScreen(),
          DashBoard.id: (context) => DashBoard(),
          CaloriePredictorScreen.id: (context) => CaloriePredictorScreen(),
          LoadingScreen.id: (context) => LoadingScreen(),
          CalorieResults.id: (context) => CalorieResults(),
        },
      ),
    );
  }
}
