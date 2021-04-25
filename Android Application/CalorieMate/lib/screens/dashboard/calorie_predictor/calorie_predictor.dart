import 'package:calorie_mate/general_components/appbar.dart';
import 'package:calorie_mate/general_components/h3.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class CaloriePredictorScreen extends StatefulWidget {
  @override
  _CaloriePredictorScreenState createState() => _CaloriePredictorScreenState();
}

class _CaloriePredictorScreenState extends State<CaloriePredictorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarPageName(pageName: "Calorie Predictor", helpAlertTitle: "Calorie Predictor Help", helpAlertBody: "Take top view and side view image of your meal using our camera. For accurate results take the picture approximately two feet away from your meal."),
        backgroundColor: kBackgroundColor,
        body: SafeArea(
            top: true,
            child: Center(child: H3(textBody: "Coming Soon"))
        ));
  }
}
