import 'package:calorie_mate/general_components/appbar.dart';
import 'package:calorie_mate/general_components/h3.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class StatisticsScreen extends StatefulWidget {
  @override
  _StatisticsScreenState createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWithoutHome(
            pageName: "Dashboard",
            helpAlertTitle: "Statistics Help",
            helpAlertBody:
                "View statistics to track progress of your fitness journey."),
        backgroundColor: kBackgroundColor,
        body: SafeArea(
            top: true, child: Center(child: H3(textBody: "Coming Soon"))));
  }
}
