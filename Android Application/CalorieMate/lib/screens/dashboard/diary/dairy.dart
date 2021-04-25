import 'package:calorie_mate/general_components/appbar.dart';
import 'package:calorie_mate/general_components/h3.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class DiaryScreen extends StatefulWidget {
  @override
  _DiaryScreenState createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarPageName(pageName: "Diary", helpAlertTitle: "Diary Help", helpAlertBody: "Log daily calories either manually or using our calorie predictor."),
        backgroundColor: kBackgroundColor,
        body: SafeArea(
            top: true,
            child: Center(child: H3(textBody: "Coming Soon"))
        ));
  }
}
