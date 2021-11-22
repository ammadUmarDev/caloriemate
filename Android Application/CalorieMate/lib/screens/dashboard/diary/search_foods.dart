import 'package:calorie_mate/general_components/appbar.dart';
import 'package:calorie_mate/models/diaryData.dart';
import 'package:calorie_mate/providers/diary_firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../../../models/food_calories.dart';
import 'package:flutter/services.dart' as rootBundle;

import '../../../constants.dart';
import '../../../utils.dart';

class SearchFoods extends StatefulWidget {
  final String type;

  const SearchFoods({
    Key key,
    @required this.type,
  }) : super(key: key);

  static final String id = '/SearchFoods';

  @override
  _SearchFoodsState createState() => _SearchFoodsState();
}

class _SearchFoodsState extends State<SearchFoods> {
  final controller = TextEditingController();

  List<FoodCalories> items = [];
  List<FoodCalories> itemsDisplay = [];

  bool isLoading = false;

  String convertDateTimeDisplay(String date) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    final DateFormat serverFormater = DateFormat('dd-MM-yyyy');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    return formatted;
  }

  @override
  void initState() {
    readJsonData().then((value) {
      setState(() {
        isLoading = false;
        items.addAll(value);
        itemsDisplay = items;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double pageHeight = MediaQuery.of(context).size.height.toDouble();
    final double pageWidth = MediaQuery.of(context).size.width.toDouble();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBarPageName(
        pageName: "Search Foods",
        helpAlertTitle: "Search Foods Help",
        helpAlertBody: "Search for foods to log in to your diary.",
        leading: true,
      ),
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        top: true,
        child: Column(
          children: <Widget>[
            _searchBar(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    if (!isLoading) {
                      return _listItem(index);
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                  itemCount: itemsDisplay.length,
                  physics: ScrollPhysics(parent: BouncingScrollPhysics()),
                ),
              ),
            ),
          ],
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
    String name = itemsDisplay[index].name.toString();
    double portion = double.parse(itemsDisplay[index].portion);
    double amount = double.parse(itemsDisplay[index].amount);
    String portionName = itemsDisplay[index].portionName.toString();
    double calories = double.parse(itemsDisplay[index].calories);
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
          onTap: () {
            Alert(
              type: AlertType.none,
              context: context,
              title: "Add to Diary?",
              desc: name +
                  "\n" +
                  amount.toStringAsFixed(2) +
                  " " +
                  portionName +
                  "\n" +
                  calories.toStringAsFixed(0) +
                  " calories",
              closeIcon: Icon(
                FontAwesomeIcons.timesCircle,
                color: kPrimaryLightColor,
              ),
              style: AlertStyle(
                  titleStyle: TextStyle(fontWeight: FontWeight.bold),
                  descStyle: TextStyle(fontSize: 15),
                  overlayColor: Colors.black45,
                  alertAlignment: Alignment.bottomCenter),
              buttons: [
                DialogButton(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  color: Colors.red.shade100,
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Cancel",
                        style: TextStyle(
                            color: kNavyBlue, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 5),
                      Icon(
                        MaterialIcons.cancel,
                        color: kNavyBlue,
                      ),
                    ],
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                DialogButton(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  color: kYellow,
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Yes",
                        style: TextStyle(
                            color: kNavyBlue, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 5),
                      Icon(
                        MaterialIcons.check_circle,
                        color: kNavyBlue,
                      ),
                    ],
                  ),
                  onPressed: () {
                    DiaryData logData = new DiaryData(
                      userId: FirebaseAuth.instance.currentUser.uid,
                      id: itemsDisplay[index].id,
                      name: itemsDisplay[index].name,
                      portion: itemsDisplay[index].portion,
                      amount: itemsDisplay[index].amount,
                      portionName: itemsDisplay[index].portionName,
                      calories: itemsDisplay[index].calories,
                      date: convertDateTimeDisplay(DateTime.now().toString()),
                      time: TimeOfDay.now(),
                      type: widget.type,
                    );
                    createLog(logData).whenComplete(() {
                      Alert(
                        type: AlertType.success,
                        context: context,
                        title: "Added Successfully!",
                        closeIcon: Icon(
                          FontAwesomeIcons.timesCircle,
                          color: kPrimaryLightColor,
                        ),
                        style: AlertStyle(
                            overlayColor: Colors.black45,
                            alertAlignment: Alignment.bottomCenter),
                        buttons: [
                          DialogButton(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            color: kNavyBlue,
                            height: 40,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "OK",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ).show();
                    });

                    Navigator.pop(context);
                  },
                ),
              ],
            ).show();
          },
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

  _searchBar() {
    return Container(
      // padding: EdgeInsets.symmetric(vertical: 16, horizontal: 14),
      padding: EdgeInsets.fromLTRB(12, 12, 12, 14),
      color: kNavyBlue,
      child: Material(
        elevation: 5,
        shadowColor: Colors.black45,
        borderRadius: BorderRadius.circular(10),
        child: TextField(
          decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
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
          onChanged: (text) {
            text = text.toLowerCase();
            setState(() {
              itemsDisplay = items.where((item) {
                var itemName = item.name.toLowerCase();
                return itemName.contains(text);
              }).toList();
            });
          },
        ),
      ),
    );
  }
}
