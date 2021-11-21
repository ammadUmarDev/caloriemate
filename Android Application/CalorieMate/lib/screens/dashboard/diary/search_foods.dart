import 'package:calorie_mate/general_components/appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import '../../../models/food_calories.dart';
import 'package:flutter/services.dart' as rootBundle;

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

  List<FoodCalories> items = [];
  List<FoodCalories> itemsDisplay = [];

  @override
  void initState() {
    readJsonData().then((value) {
      items.addAll(value);
      itemsDisplay = items;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double pageHeight = MediaQuery.of(context).size.height.toDouble();
    final double pageWidth = MediaQuery.of(context).size.width.toDouble();

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
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 14),
                color: kNavyBlue,
                child: Material(
                  elevation: 5,
                  shadowColor: Colors.black45,
                  borderRadius: BorderRadius.circular(12),
                  child: TextField(
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 16.0, 20.0, 16.0),
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
              ),
              Container(
                margin: EdgeInsets.only(top: 4, right: 4, left: 4),
                height: pageHeight,
                width: pageWidth,
                child: FutureBuilder(
                  future: readJsonData(),
                  builder: (context, data) {
                    if (data.hasError) {
                      print(data.error);
                      return Center(
                        child: Text("${data.error}"),
                      );
                    } else if (data.hasData) {
                      // items = data.data;
                      return ListView.builder(itemBuilder: (context, index) {
                        if (items.length > 0) {
                          return
                              // index == 0 ? _searchBar() :
                              _listItem(index);
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      });
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<List<FoodCalories>> readJsonData() async {
    final jsonData = await rootBundle.rootBundle
        .loadString("assets/json/food_calories.json");
    final list = json.decode(jsonData) as List<dynamic>;

    return list.map((e) => FoodCalories.fromJsonLocal(e)).toList();
  }

  Widget _listItem(int index) {
    String name = items[index].name.toString();
    double portion = double.parse(items[index].portion);
    double amount = double.parse(items[index].amount);
    String portionName = items[index].portionName.toString();
    double calories = double.parse(items[index].calories);
    double totalAmount = portion * amount;
    return Container(
      height: 100,
      child: Card(
        color: Colors.white,
        elevation: 5,
        shadowColor: Colors.black45,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: InkWell(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 7,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        name,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        totalAmount.toStringAsFixed(2) + " " + portionName,
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        calories.toStringAsFixed(0),
                        style: TextStyle(
                          fontSize: 20,
                          color: kCGBlue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "calories",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _searchBar() {}
}
