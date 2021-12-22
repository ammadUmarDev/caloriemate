import 'package:calorie_mate/constants.dart';
import 'package:calorie_mate/providers/firebase_functions.dart';
import 'package:calorie_mate/providers/general_provider.dart';
import 'package:calorie_mate/screens/dashboard/calorie_predictor/calorie_results.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:calorie_mate/general_components/appbar.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../models/calories_data.dart';

class CalorieResult {
  String name;
  double volume;
  double weight;
  double calories;
  String ErrorMessage;

  CalorieResult(this.name, this.volume, this.weight, this.calories, this.ErrorMessage);

  factory CalorieResult.fromJson(dynamic json) {
    return CalorieResult(json['name'] as String, json['volume'] as double, json['weight'] as double, json['calories'] as double, json['ErrorMessage'] as String);
  }

  @override
  String toString() {
    return '{ ${this.name}, ${this.volume}, ${this.weight}, ${this.calories}, ${this.ErrorMessage} }';
  }
}

class ServerResponse {
  final String name;
  final double calories;

  ServerResponse({this.name, this.calories});

  factory ServerResponse.fromJson(Map<String, dynamic> json) {
    return ServerResponse(
        name: json['name'] ,
        calories: json['calories']
    );
  }
}

class LoadingScreen extends StatefulWidget {
  static final String id = '/LoadingScreen';

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  final databaseReference =
      FirebaseDatabase.instance.reference().child('result').child('calories');

  void setupCaloriePrediction() async {
    await Future.delayed(Duration(seconds: 10));
    // some instance
    CalorieModel object = CalorieModel();
    final serverURL = Provider.of<General_Provider>(context, listen: false).get_caloriePredictorSeverURL();
    print(serverURL.toString()+'/generateResults');
    final response = await http.get(Uri.parse(serverURL.toString()+'/predictCalories'));
    print(response);
    final parsed = json.decode(response.body);
    print(parsed);
    print(parsed.runtimeType);
    final calorieResult = CalorieResult.fromJson(jsonDecode(parsed));
    print(parsed[5]);
    final predictedName = calorieResult.name;
    print(predictedName);
    final predictedWeight = calorieResult.weight;
    print(predictedWeight);
    final predictedCalories = calorieResult.calories;
    print(predictedCalories);
    final error = calorieResult.ErrorMessage;
    print(error);
    // print(response.statusCode);
    // print(response.body);
    // // databaseReference.once().then((DataSnapshot data) {
    // //   setState(() {
    // //     object.calories = '${data.value}';
    // //   });
    // // });
    // final jsonResponse = ServerResponse.fromJson(jsonDecode(response.body));
    // object.name = jsonResponse.name;
    // object.calories = jsonResponse.calories;

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CalorieResults(
            predictedName: predictedName,
            predictedWeight: predictedWeight,
            predictedCalories: predictedCalories,
            error: error,

        ),
      ),
    );
  }

  @override
  void initState() {
    setupCaloriePrediction();
    getWorkoutRecommenderSeverURL(context);
    getCaloriePredictorSeverURL(context);
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