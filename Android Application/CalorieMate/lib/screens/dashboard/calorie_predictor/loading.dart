import 'package:calorie_mate/constants.dart';
import 'package:calorie_mate/screens/dashboard/calorie_predictor/calorie_results.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:calorie_mate/general_components/appbar.dart';
import 'dart:async';

import '../../../models/calories_data.dart';

class LoadingScreen extends StatefulWidget {
  static final String id = '/LoadingScreen';

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  final databaseReference =
      FirebaseDatabase.instance.reference().child('result').child('calories');

  void setupCaloriePrediction() async {
    // some instance
    CalorieModel object = CalorieModel();

    // await for data
    await Future.delayed(Duration(seconds: 1));

    databaseReference.once().then((DataSnapshot data) {
      setState(() {
        object.calories = '${data.value}';
      });
    });
    object.calories = "48.637";
    object.quantity = 98;

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CalorieResults(
            predictedCalories: object.calories,
            predictedQuantity: object.quantity),
      ),
    );
  }

  @override
  void initState() {
    setupCaloriePrediction();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarPageName(
          pageName: "Calorie Predictor",
          helpAlertTitle: "Calorie Predictor Loading Help",
          helpAlertBody: "Please wait while the results load."),
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        top: true,
        child: Center(
          child: SpinKitDualRing(
            color: kPrimaryAccentColor,
            duration: Duration(seconds: 1),
            size: 50,
          ),
        ),
      ),
    );
  }
}
