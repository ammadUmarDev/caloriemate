import 'package:calorie_mate/general_components/appbar.dart';
import 'package:calorie_mate/general_components/h3.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class ToolsScreen extends StatefulWidget {
  @override
  _ToolsScreenState createState() => _ToolsScreenState();
}

class _ToolsScreenState extends State<ToolsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarPageName(pageName: "Tools", helpAlertTitle: "Tools Help", helpAlertBody: "Different tools for you to make wiser fitness decisions. "),
        backgroundColor: kBackgroundColor,
        body: SafeArea(
            top: true,
            child: Center(child: H3(textBody: "Coming Soon"))
        ));
  }
}