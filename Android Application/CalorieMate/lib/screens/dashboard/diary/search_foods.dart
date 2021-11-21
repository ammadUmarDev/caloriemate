import 'package:calorie_mate/general_components/appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../constants.dart';

class SearchFoods extends StatefulWidget {
  // final String text;
  // final ValueChanged<String> onChanged;
  // final String hintText;

  // const SearchFoods({
  //   Key key,
  //    this.text,
  //    this.onChanged,
  //    this.hintText,
  //  }) : super(key: key);

  static final String id = '/SearchFoods';

  @override
  _SearchFoodsState createState() => _SearchFoodsState();
}

class _SearchFoodsState extends State<SearchFoods> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double pageHeight = MediaQuery.of(context).size.height.toDouble();
    final double pageWidth = MediaQuery.of(context).size.width.toDouble();

    // final styleActive = TextStyle(color: Colors.black87);
    // final styleHint = TextStyle(color: Colors.black54);

    return Scaffold(
      appBar: AppBarPageName(
        pageName: "Search Foods",
        helpAlertTitle: "Search Foods Help",
        helpAlertBody: "Search for foods to log in to your diary.",
        leading: true,
      ),
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Column(
              children: <Widget>[
                Material(
                  elevation: 6,
                  shadowColor: Colors.black45,
                  borderRadius: BorderRadius.circular(12),
                  child: TextField(
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 18.0, 20.0, 18.0),
                      prefixIcon: IconButton(
                        icon: Icon(
                          Icons.search,
                          color: Colors.black54,
                        ),
                        onPressed: () {},
                      ),
                      hintText: "Search",
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                // ListView.builder(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
