import 'package:calorie_mate/providers/general_provider.dart';
import 'package:calorie_mate/screens/authentication/login_signup.dart';
import 'package:calorie_mate/screens/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        initialRoute: DashBoard.id,
        routes: {
          LoginSignupScreen.id: (context) => LoginSignupScreen(),
          DashBoard.id: (context) => DashBoard(),
        },
      ),
    );
  }
}
