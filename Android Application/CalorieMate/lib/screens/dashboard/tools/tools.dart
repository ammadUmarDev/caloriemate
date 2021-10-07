// import 'dart:html';
import 'package:calorie_mate/general_components/appbar.dart';
import 'package:calorie_mate/general_components/rounded_icon_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'dart:io';

import '../../../constants.dart';
import '../../../general_components/h1.dart';
import '../../../general_components/h2.dart';
import '../../../general_components/h3.dart';

class ToolsScreen extends StatefulWidget {
  @override
  _ToolsScreenState createState() => _ToolsScreenState();
}

class _ToolsScreenState extends State<ToolsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarPageName(
          pageName: "Tools",
          helpAlertTitle: "Tools Help",
          helpAlertBody:
              "Different tools for you to make wiser fitness decisions. "),
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        top: true,
        child: Padding(
          padding:
              const EdgeInsets.only(top: 10, left: 32, right: 32, bottom: 36),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Tools",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87),
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Spacer(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  RoundedIconButton(
                    text: "Intake Recommender",
                    icon: MaterialCommunityIcons.silverware_variant,
                    color: kDarkAccentColor,
                    textColor: Colors.white,
                    press: () {
                      Navigator.of(context).pushNamed('/IntakeRecommender');
                    },
                  ),
                  Spacer(),
                  RoundedIconButton(
                    text: "Workout Recommender",
                    icon: MaterialCommunityIcons.run,
                    color: kDarkAccentColor,
                    textColor: Colors.white,
                    press: () => {},
                  )
                ],
              ),
              Spacer(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  RoundedIconButton(
                    text: "Meal Planner",
                    icon: MaterialCommunityIcons.food_apple,
                    color: kDarkAccentColor,
                    textColor: Colors.white,
                    press: () => {},
                  ),
                  Spacer(),
                  RoundedIconButton(
                    text: "Workout Planner",
                    icon: MaterialCommunityIcons.human_handsup,
                    color: kDarkAccentColor,
                    textColor: Colors.white,
                    press: () {
                      Navigator.of(context).pushNamed('/WorkoutPlanner');
                    },
                  )
                ],
              ),
              Spacer(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  RoundedIconButton(
                    text: "Weight Tracker",
                    icon: MaterialCommunityIcons.scale_bathroom,
                    color: kDarkAccentColor,
                    textColor: Colors.white,
                    press: () {
                      Navigator.of(context).pushNamed('/WeightTracker');
                    },
                  ),
                  // SizedBox(width: 30),
                  Spacer(),
                  RoundedIconButton(
                    text: "BMI Calculator",
                    icon: MaterialCommunityIcons.calculator,
                    color: kDarkAccentColor,
                    textColor: Colors.white,
                    press: () {
                      Navigator.of(context).pushNamed('/BMICalculator');
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
