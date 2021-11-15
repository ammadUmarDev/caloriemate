// import 'dart:html';
import 'package:calorie_mate/general_components/appbar.dart';
import 'package:calorie_mate/general_components/rounded_icon_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/svg.dart';
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
          leading: false,
          helpAlertTitle: "Tools Help",
          helpAlertBody:
              "Different tools for you to make wiser fitness decisions. "),
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        top: true,
        child: Padding(
          padding:
              const EdgeInsets.only(top: 10, left: 32, right: 32, bottom: 40),
          child: Column(
            children: [
              // SizedBox(height: 20),
              Spacer(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RoundedIconButton(
                    text: "Intake Recommender",
                    icon:
                        SvgPicture.asset("assets/svgs/intake3.svg", height: 90),
                    // icon: MaterialCommunityIcons.silverware_variant,
                    color: kCGBlue,
                    textColor: Colors.white,
                    press: () {
                      Navigator.of(context).pushNamed('/IntakeRecommender');
                    },
                  ),
                  Spacer(),
                  RoundedIconButton(
                    text: "Workout Recommender",
                    icon: SvgPicture.asset("assets/svgs/workout2.svg",
                        height: 90),

                    // icon: MaterialCommunityIcons.run,
                    color: kCGBlue,
                    textColor: Colors.white,
                    press: () {
                      Navigator.of(context).pushNamed('/WorkoutRecommender');
                    },
                  )
                ],
              ),
              Spacer(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  RoundedIconButton(
                    text: "Meal Planner",
                    icon: SvgPicture.asset("assets/svgs/mealplan.svg",
                        height: 90),

                    // icon: MaterialCommunityIcons.food_apple,
                    color: kCGBlue,
                    textColor: Colors.white,
                    press: () => {},
                  ),
                  Spacer(),
                  RoundedIconButton(
                    text: "Workout Planner",
                    icon: SvgPicture.asset("assets/svgs/workoutplan.svg",
                        height: 90),

                    // icon: MaterialCommunityIcons.human_handsup,
                    color: kCGBlue,
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
                    icon:
                        SvgPicture.asset("assets/svgs/weight.svg", height: 90),

                    // icon: MaterialCommunityIcons.scale_bathroom,
                    color: kCGBlue,
                    textColor: Colors.white,
                    press: () {
                      Navigator.of(context).pushNamed('/WeightTracker');
                    },
                  ),
                  // SizedBox(width: 30),
                  Spacer(),
                  RoundedIconButton(
                    text: "BMI Calculator",
                    icon: SvgPicture.asset("assets/svgs/bmi.svg", height: 90),

                    // icon: MaterialCommunityIcons.calculator,
                    color: kCGBlue,
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
