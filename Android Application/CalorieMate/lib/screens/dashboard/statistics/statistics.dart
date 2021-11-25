import 'dart:ui';

import 'package:calorie_mate/general_components/appbar.dart';
import 'package:calorie_mate/general_components/h3.dart';
import 'package:calorie_mate/models/user.dart';
import 'package:calorie_mate/providers/general_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

class StatisticsScreen extends StatefulWidget {
  @override
  _StatisticsScreenState createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  UserModel userObj;

  @override
  void initState() {
    super.initState();
    userObj = Provider.of<General_Provider>(context, listen: false).get_user();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithoutHome(
          pageName: "Statistics",
          helpAlertTitle: "Statistics Help",
          helpAlertBody:
              "View statistics to track progress of your fitness journey."),
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        top: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    "Hello, " + userObj.fullName.split(" ").first + "! 👋",
                    style: TextStyle(
                      fontSize: 32,
                      fontFamily: "Quicksand-Bold",
                      fontWeight: FontWeight.bold,
                      color: kPrussianBlue,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
