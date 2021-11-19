import 'dart:io';
import 'dart:math';
import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:calorie_mate/general_components/body_text%20copy.dart';
import 'package:calorie_mate/general_components/card.dart';
import 'package:calorie_mate/general_components/h2.dart';
import 'package:calorie_mate/general_components/shadowBoxList.dart';
import 'package:calorie_mate/models/user.dart';
import 'package:calorie_mate/providers/firebase_functions.dart';
import 'package:calorie_mate/providers/general_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../../../constants.dart';
import '../../../general_components/appbar.dart';
import '../../../general_components/buttonErims.dart';
import '../../../general_components/h1.dart';
import '../../../general_components/h3.dart';

enum Gender { male, female }

enum HeightUnit { ft, cm }
enum WeightUnit { kg, lbs }

enum PhysicalActivityLevel { Sedentary, Light, Moderate, Vigorous }

extension ParseToString on PhysicalActivityLevel {
  String toShortString() {
    return this.toString().split('.').last;
  }
}

class IntakeRecommender extends StatefulWidget {
  static final String id = '/IntakeRecommender';
  @override
  _IntakeRecommenderState createState() => _IntakeRecommenderState();
}

class _IntakeRecommenderState extends State<IntakeRecommender> {
  List<BoxShadow> shadow = [
    BoxShadow(color: Colors.black12, offset: Offset(0, 3), blurRadius: 6)
  ];

  Gender selectedGender;
  PhysicalActivityLevel _physicalActivityLevel;
  UserModel userObj;

  //Height Variables and functions

  HeightUnit selectedUnit = HeightUnit.ft;
  TextEditingController heightController = TextEditingController();
  int ft = 5;
  int inches = 0;
  int cm;
  int height;

  int index = 4;
  int index4 = 169;

  FixedExtentScrollController scrollController;
  FixedExtentScrollController scrollController4;

  feetToCm() {
    int inchesTotal = (ft * 12) + inches;
    cm = (inchesTotal * 2.54).toInt();
    height = cm;
    print(height);
  }

  void checkHeightUnit() {
    if (selectedUnit == HeightUnit.ft) {
      setState(() {
        heightController.text = '__\' __"';
      });
    } else if (selectedUnit == HeightUnit.cm) {
      setState(() {
        print(heightController.text);
        heightController.text = '__';
      });
    }
  }

  //BMI Calculation
  double bmi;

  String calculateBMI() {
    if (selectedGender == Gender.male) {
      bmi = 88.362 + (13.397 * weight) + (4.799 * height) - (5.677 * age);
    }

    if (selectedGender == Gender.female) {
      bmi = 447.593 + (9.247 * weight) + (3.098 * height) - (4.330 * age);
    }

    return bmi.toStringAsFixed(1);
  }

  String bmiDescription;
  String bmiType;

  setBMIDescription() {
    if (_physicalActivityLevel == PhysicalActivityLevel.Sedentary) {
      bmiDescription = (bmi * 1.1).toStringAsFixed(0);
      bmiType = (bmi * 0.9).toStringAsFixed(0) + " calories per day.";
    }

    if (_physicalActivityLevel == PhysicalActivityLevel.Light) {
      bmiDescription = (bmi * 1.3).toStringAsFixed(0);
      bmiType = (bmi * 1.1).toStringAsFixed(0) + " calories per day";
    }

    if (_physicalActivityLevel == PhysicalActivityLevel.Moderate) {
      bmiDescription = (bmi * 1.5).toStringAsFixed(0);
      bmiType = (bmi * 1.3).toStringAsFixed(0) + " calories per day";
    }

    if (_physicalActivityLevel == PhysicalActivityLevel.Vigorous) {
      bmiDescription = (bmi * 1.7).toStringAsFixed(0);
      bmiType = (bmi * 1.5).toStringAsFixed(0) + " calories per day";
    }
  }

  //Weight Variables and functions
  WeightUnit SelectedUnitW = WeightUnit.kg;
  TextEditingController weightController = TextEditingController();
  var kg = 65;
  var lbs = 160;
  int weight;

  int index1 = 74;
  int index2 = 159;

  FixedExtentScrollController scrollController1;
  FixedExtentScrollController scrollController2;

  void checkWeightUnit() {
    if (SelectedUnitW == WeightUnit.kg) {
      setState(() {
        weightController.text = '$kg';
      });
    } else if (SelectedUnitW == WeightUnit.lbs) {
      setState(() {
        weightController.text = '$lbs';
      });
    }
  }

  poundsToKg() {
    if (SelectedUnitW == WeightUnit.kg) {
      setState(() {
        weight = kg;
      });
    } else if (SelectedUnitW == WeightUnit.lbs) {
      setState(() {
        weight = lbs ~/ 2.20462;
      });
    }
  }

  //Age Variables and functions
  TextEditingController ageController = TextEditingController();
  var age = 20;
  int index3 = 20;
  FixedExtentScrollController scrollController3;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController = FixedExtentScrollController(initialItem: index);
    scrollController1 = FixedExtentScrollController(initialItem: index1);
    scrollController2 = FixedExtentScrollController(initialItem: index2);
    scrollController3 = FixedExtentScrollController(initialItem: index3);
    scrollController4 = FixedExtentScrollController(initialItem: index4);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    scrollController.dispose();
    scrollController1.dispose();
    scrollController2.dispose();
    scrollController3.dispose();
    scrollController4.dispose();
    heightController.dispose();
    weightController.dispose();
    ageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double pageHeight = MediaQuery.of(context).size.height.toDouble();
    final double pageWidth = MediaQuery.of(context).size.width.toDouble();
    return Scaffold(
      appBar: AppBarPageName(
          pageName: "Intake Recommender",
          helpAlertTitle: "Intake Recommender Help",
          helpAlertBody: "Get a recommendation on your daily calorie intake."),
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
                child: Column(
                  children: <Widget>[
                    //Gender Picker
                    Row(
                      children: <Widget>[
                        SizedBox(
                          height: pageHeight * 0.18,
                          child: SelectionCard(
                            onPress: () {
                              setState(() {
                                selectedGender = Gender.male;
                              });
                            },
                            color: selectedGender == Gender.male
                                ? kActiveCardColour
                                : kInactiveCardColour,
                            icon: SvgPicture.asset("assets/svgs/male.svg",
                                width: 80),
                            text: 'MALE',
                            textColor: Colors.white,
                          ),
                        ),
                        Spacer(),
                        SizedBox(
                          height: pageHeight * 0.18,
                          child: SelectionCard(
                            onPress: () {
                              setState(() {
                                selectedGender = Gender.female;
                              });
                            },
                            color: selectedGender == Gender.female
                                ? kActiveCardColour
                                : kInactiveCardColour,
                            icon: SvgPicture.asset("assets/svgs/female.svg",
                                width: 80),
                            text: 'FEMALE',
                            textColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    //HeightPicker
                    Container(
                      padding: EdgeInsets.all(20),
                      margin: EdgeInsets.only(top: 16),
                      decoration: BoxDecoration(
                        color: kCGBlue,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4.0,
                            spreadRadius: 1.5,
                            offset: Offset(0, 3.0),
                            // shadow direction: bottom right
                          )
                        ],
                      ),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Height",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24,
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  SvgPicture.asset("assets/svgs/height.svg",
                                      width: 36)
                                  // Icon(
                                  //   // MaterialCommunityIcons.ruler,
                                  //   FontAwesomeIcons.rulerVertical,
                                  //   color: Colors.white,
                                  //   size: 30,
                                  // ),
                                ],
                              ),
                            ],
                          ),
                          Divider(
                            color: Colors.white,
                            height: 20,
                            thickness: 3,
                          ),
                          Row(children: <Widget>[
                            Container(
                              width: 160,
                              child: TextFormField(
                                onTap: selectedUnit == HeightUnit.ft
                                    ? () {
                                        FocusScope.of(context)
                                            .requestFocus(new FocusNode());
                                        showCupertinoModalPopup(
                                            context: context,
                                            builder: (context) {
                                              return Container(
                                                height: 300,
                                                color: Colors.white,
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 4,
                                                      child: CupertinoPicker(
                                                        scrollController:
                                                            scrollController,
                                                        itemExtent: 64.0,
                                                        magnification: 1.3,
                                                        squeeze: 1.3,
                                                        selectionOverlay:
                                                            CupertinoPickerDefaultSelectionOverlay(
                                                          background: Colors
                                                              .blue
                                                              .withOpacity(0.2),
                                                        ),
                                                        onSelectedItemChanged:
                                                            (int index) {
                                                          print(index + 1);
                                                          setState(() {
                                                            ft = (index + 1);
                                                            heightController
                                                                    .text =
                                                                "$ft' $inches\"";
                                                          });
                                                        },
                                                        children: List.generate(
                                                            12, (index) {
                                                          return Center(
                                                            child: Text(
                                                              '${index + 1}',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Quicksand',
                                                              ),
                                                            ),
                                                          );
                                                        }),
                                                      ),
                                                    ),
                                                    Expanded(
                                                        flex: 1,
                                                        child: Center(
                                                            child: Text('ft',
                                                                style:
                                                                    TextStyle(
                                                                  decoration:
                                                                      TextDecoration
                                                                          .none,
                                                                  fontSize: 17,
                                                                  fontFamily:
                                                                      'Quicksand',
                                                                  color: Colors
                                                                      .black87,
                                                                )))),
                                                    Expanded(
                                                      flex: 2,
                                                      child: CupertinoPicker(
                                                        // backgroundColor: kDarkAccentColor,
                                                        itemExtent: 64.0,
                                                        magnification: 1.3,
                                                        squeeze: 1.3,
                                                        selectionOverlay:
                                                            CupertinoPickerDefaultSelectionOverlay(
                                                          background: Colors
                                                              .blue
                                                              .withOpacity(0.2),
                                                        ),
                                                        onSelectedItemChanged:
                                                            (int index) {
                                                          print(index);
                                                          setState(() {
                                                            inches = (index);
                                                            heightController
                                                                    .text =
                                                                "$ft' $inches\"";
                                                            feetToCm();
                                                          });
                                                        },
                                                        children: List.generate(
                                                            12, (index) {
                                                          return Center(
                                                            child: Text(
                                                              '$index',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Quicksand',
                                                              ),
                                                            ),
                                                          );
                                                        }),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: Center(
                                                          child: Text('inches',
                                                              style: TextStyle(
                                                                decoration:
                                                                    TextDecoration
                                                                        .none,
                                                                fontSize: 17,
                                                                fontFamily:
                                                                    'Quicksand',
                                                                color: Colors
                                                                    .black87,
                                                              ))),
                                                    )
                                                  ],
                                                ),
                                              );
                                            });
                                      }
                                    : () {
                                        FocusScope.of(context)
                                            .requestFocus(new FocusNode());
                                        showCupertinoModalPopup(
                                            context: context,
                                            builder: (context) {
                                              return Container(
                                                  height: 300,
                                                  color: Colors.white,
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                          flex: 4,
                                                          child:
                                                              CupertinoPicker(
                                                                  scrollController:
                                                                      scrollController4,
                                                                  itemExtent:
                                                                      40.0,
                                                                  magnification:
                                                                      1.3,
                                                                  squeeze: 1.3,
                                                                  selectionOverlay:
                                                                      CupertinoPickerDefaultSelectionOverlay(
                                                                    background: Colors
                                                                        .blue
                                                                        .withOpacity(
                                                                            0.2),
                                                                  ),
                                                                  onSelectedItemChanged:
                                                                      (int
                                                                          index) {
                                                                    print(
                                                                        index +
                                                                            1);
                                                                    setState(
                                                                        () {
                                                                      cm = (index +
                                                                          1);
                                                                      heightController
                                                                              .text =
                                                                          "$cm";
                                                                      height =
                                                                          cm;
                                                                    });
                                                                  },
                                                                  children: List
                                                                      .generate(
                                                                          280,
                                                                          (index) {
                                                                    return Center(
                                                                        child: Text(
                                                                            '${index + 1}',
                                                                            style:
                                                                                TextStyle(fontFamily: 'Quicksand')));
                                                                  }))),
                                                      Expanded(
                                                          flex: 1,
                                                          child: Center(
                                                              child: Text('cm',
                                                                  style: TextStyle(
                                                                      decoration:
                                                                          TextDecoration
                                                                              .none,
                                                                      fontSize:
                                                                          17,
                                                                      fontFamily:
                                                                          'Quicksand',
                                                                      color: Colors
                                                                          .black87)))),
                                                    ],
                                                  ));
                                            });
                                      },
                                controller: heightController,
                                keyboardType: TextInputType.number,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                                textAlign: TextAlign.center,
                                cursorColor: Colors.white,
                                decoration: InputDecoration(
                                    hintText: selectedUnit == HeightUnit.ft
                                        ? "_' _\""
                                        : '_',
                                    hintStyle: TextStyle(color: Colors.white),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white, width: 1.8)),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white, width: 1.8))),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp("[0-9.]"))
                                ],
                              ),
                            ),
                            SizedBox(width: 25),
                            Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (heightController.text.isEmpty) {
                                          selectedUnit = HeightUnit.ft;
                                        } else {
                                          selectedUnit = HeightUnit.ft;
                                          checkHeightUnit();
                                        }
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: selectedUnit == HeightUnit.ft
                                            ? kActiveCardColour
                                            : Colors.transparent,
                                      ),
                                      width: 50,
                                      height: 50,
                                      child: Center(
                                          child: Text('ft',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontFamily: 'Quicksand',
                                                  color: Colors.white,
                                                  fontWeight:
                                                      FontWeight.bold))),
                                    ))),
                            Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (heightController.text.isEmpty) {
                                          selectedUnit = HeightUnit.cm;
                                        } else {
                                          selectedUnit = HeightUnit.cm;
                                          checkHeightUnit();
                                        }
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: selectedUnit == HeightUnit.cm
                                            ? kActiveCardColour
                                            : Colors.transparent,
                                      ),
                                      width: 50,
                                      height: 50,
                                      child: Center(
                                          child: Text('cm',
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontFamily: 'Quicksand',
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ))),
                                    )))
                          ])
                        ],
                      ),
                    ),
                    Row(children: <Widget>[
                      //WeightPicker
                      Container(
                          width: pageWidth * 0.436,
                          height: pageHeight * 0.26,
                          padding: EdgeInsets.all(20),
                          margin: EdgeInsets.only(top: 16),
                          decoration: BoxDecoration(
                            color: kCGBlue,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 4.0,
                                spreadRadius: 1.5,
                                offset: Offset(0, 3.0),
                                // shadow direction: bottom right
                              )
                            ],
                          ),
                          child: Column(children: <Widget>[
                            Row(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Weight",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24,
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    SvgPicture.asset("assets/svgs/weight2.svg",
                                        width: 30),
                                    // Icon(
                                    //   // MaterialCommunityIcons.ruler,
                                    //   FontAwesomeIcons.weight,
                                    //   color: Colors.white,
                                    //   size: 26,
                                    // ),
                                  ],
                                ),
                              ],
                            ),
                            Divider(
                              color: Colors.white,
                              height: 24,
                              thickness: 3,
                            ),
                            Row(children: <Widget>[
                              Container(
                                  width: 135,
                                  child: TextFormField(
                                      onTap: SelectedUnitW == WeightUnit.kg
                                          ? () {
                                              FocusScope.of(context)
                                                  .requestFocus(
                                                      new FocusNode());
                                              showCupertinoModalPopup(
                                                  context: context,
                                                  builder: (context) {
                                                    return Container(
                                                        height: 300,
                                                        color: Colors.white,
                                                        child: Row(children: [
                                                          Expanded(
                                                              flex: 4,
                                                              child:
                                                                  CupertinoPicker(
                                                                      scrollController:
                                                                          scrollController1,
                                                                      itemExtent:
                                                                          40.0,
                                                                      magnification:
                                                                          1.3,
                                                                      squeeze:
                                                                          1.3,
                                                                      selectionOverlay:
                                                                          CupertinoPickerDefaultSelectionOverlay(
                                                                        background: Colors
                                                                            .blue
                                                                            .withOpacity(0.2),
                                                                      ),
                                                                      onSelectedItemChanged:
                                                                          (int
                                                                              index) {
                                                                        print(index +
                                                                            1);
                                                                        setState(
                                                                            () {
                                                                          kg = (index +
                                                                              1);
                                                                          weightController.text =
                                                                              "$kg";
                                                                          weight =
                                                                              kg;
                                                                        });
                                                                      },
                                                                      children: List.generate(
                                                                          250,
                                                                          (index) {
                                                                        return Center(
                                                                            child:
                                                                                Text('${index + 1}', style: TextStyle(fontFamily: 'Quicksand')));
                                                                      }))),
                                                          Expanded(
                                                              flex: 2,
                                                              child: Center(
                                                                  child: Text(
                                                                      'kg',
                                                                      style: TextStyle(
                                                                          decoration: TextDecoration
                                                                              .none,
                                                                          fontSize:
                                                                              17,
                                                                          fontFamily:
                                                                              'Quicksand',
                                                                          color:
                                                                              Colors.black87)))),
                                                        ]));
                                                  });
                                            }
                                          : () {
                                              FocusScope.of(context)
                                                  .requestFocus(
                                                      new FocusNode());
                                              showCupertinoModalPopup(
                                                  context: context,
                                                  builder: (context) {
                                                    return Container(
                                                        height: 300,
                                                        color: Colors.white,
                                                        child: Row(children: [
                                                          Expanded(
                                                              flex: 4,
                                                              child:
                                                                  CupertinoPicker(
                                                                      scrollController:
                                                                          scrollController2,
                                                                      itemExtent:
                                                                          40.0,
                                                                      magnification:
                                                                          1.3,
                                                                      squeeze:
                                                                          1.3,
                                                                      selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
                                                                          background: Colors.blue.withOpacity(
                                                                              0.2)),
                                                                      onSelectedItemChanged:
                                                                          (int
                                                                              index) {
                                                                        print(index +
                                                                            1);
                                                                        setState(
                                                                            () {
                                                                          lbs = (index +
                                                                              1);
                                                                          weightController.text =
                                                                              "$lbs";
                                                                          weight =
                                                                              (lbs / 2.20462).floor();
                                                                        });
                                                                      },
                                                                      children: List.generate(
                                                                          450,
                                                                          (index) {
                                                                        return Center(
                                                                            child: Text('${index + 1}',
                                                                                style: TextStyle(
                                                                                  fontFamily: 'Quicksand',
                                                                                )));
                                                                      }))),
                                                          Expanded(
                                                              flex: 1,
                                                              child: Center(
                                                                  child: Text(
                                                                      'lbs',
                                                                      style: TextStyle(
                                                                          decoration: TextDecoration
                                                                              .none,
                                                                          fontSize:
                                                                              17,
                                                                          fontFamily:
                                                                              'Quicksand',
                                                                          color:
                                                                              Colors.black87)))),
                                                        ]));
                                                  });
                                            },
                                      controller: weightController,
                                      keyboardType: TextInputType.number,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                      textAlign: TextAlign.center,
                                      cursorColor: Colors.white,
                                      decoration: InputDecoration(
                                          hintText:
                                              SelectedUnitW == WeightUnit.kg
                                                  ? '-'
                                                  : '-',
                                          hintStyle:
                                              TextStyle(color: Colors.white),
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white,
                                                  width: 1.8)),
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white,
                                                  width: 1.8))),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp("[0-9.]"))
                                      ]))
                            ]),
                            SizedBox(height: 10),
                            Row(children: <Widget>[
                              Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          if (weightController.text.isEmpty) {
                                            SelectedUnitW = WeightUnit.kg;
                                          } else {
                                            SelectedUnitW = WeightUnit.kg;
                                            checkWeightUnit();
                                          }
                                        });
                                      },
                                      child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color:
                                                SelectedUnitW == WeightUnit.kg
                                                    ? kActiveCardColour
                                                    : Colors.transparent,
                                          ),
                                          width: 50,
                                          height: 50,
                                          child: Center(
                                              child: Text('kg',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontFamily: 'Quicksand',
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold)))))),
                              Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          if (weightController.text.isEmpty) {
                                            SelectedUnitW = WeightUnit.lbs;
                                          } else {
                                            SelectedUnitW = WeightUnit.lbs;
                                            checkWeightUnit();
                                          }
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: SelectedUnitW == WeightUnit.lbs
                                              ? kActiveCardColour
                                              : Colors.transparent,
                                        ),
                                        width: 50,
                                        height: 50,
                                        child: Center(
                                            child: Text('lbs',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontFamily: 'Quicksand',
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ))),
                                      )))
                            ])
                          ])),
                      Spacer(),
                      //AgePicker
                      Container(
                          width: pageWidth * 0.436,
                          height: pageHeight * 0.26,
                          padding: EdgeInsets.all(20),
                          margin: EdgeInsets.only(top: 16),
                          decoration: BoxDecoration(
                            color: kCGBlue,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 4.0,
                                spreadRadius: 1.5,
                                offset: Offset(0, 3.0),
                                // shadow direction: bottom right
                              )
                            ],
                          ),
                          child: Column(children: <Widget>[
                            Row(children: [
                              Row(
                                children: [
                                  Text(
                                    "Age",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24,
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  SvgPicture.asset("assets/svgs/age.svg",
                                      width: 30),
                                  // Icon(
                                  //     // MaterialCommunityIcons.,
                                  //     FontAwesomeIcons.solidCalendar,
                                  //     color: Colors.white,
                                  //     size: 30),
                                ],
                              )
                            ]),
                            Divider(
                                color: Colors.white, height: 24, thickness: 3),
                            Row(children: <Widget>[
                              Container(
                                  width: 135,
                                  child: TextFormField(
                                      onTap: () {
                                        FocusScope.of(context)
                                            .requestFocus(new FocusNode());
                                        showCupertinoModalPopup(
                                            context: context,
                                            builder: (context) {
                                              return Container(
                                                  height: 300,
                                                  color: Colors.white,
                                                  child: Row(children: [
                                                    Expanded(
                                                        flex: 4,
                                                        child: CupertinoPicker(
                                                            scrollController:
                                                                scrollController3,
                                                            itemExtent: 40.0,
                                                            magnification: 1.3,
                                                            squeeze: 1.3,
                                                            selectionOverlay:
                                                                CupertinoPickerDefaultSelectionOverlay(
                                                                    background: Colors
                                                                        .blue
                                                                        .withOpacity(
                                                                            0.2)),
                                                            onSelectedItemChanged:
                                                                (int index) {
                                                              print(index + 1);
                                                              setState(() {
                                                                age =
                                                                    (index + 1);
                                                                ageController
                                                                        .text =
                                                                    "$age";
                                                              });
                                                            },
                                                            children:
                                                                List.generate(
                                                                    120,
                                                                    (index) {
                                                              return Center(
                                                                  child: Text(
                                                                      '${index + 1}',
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              'Quicksand')));
                                                            }))),
                                                    Expanded(
                                                        flex: 2,
                                                        child: Center(
                                                            child: Text('Age',
                                                                style: TextStyle(
                                                                    decoration:
                                                                        TextDecoration
                                                                            .none,
                                                                    fontSize:
                                                                        17,
                                                                    fontFamily:
                                                                        'Quicksand',
                                                                    color: Colors
                                                                        .black87)))),
                                                  ]));
                                            });
                                      },
                                      keyboardType: TextInputType.number,
                                      controller: ageController,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                          hintText: '-',
                                          hintStyle:
                                              TextStyle(color: Colors.white),
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white,
                                                  width: 1.8)),
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white,
                                                  width: 1.8))),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp("[0-9.]"))
                                      ]))
                            ]),
                            SizedBox(height: 10),
                          ]))
                    ]),
                    //Edit Physical Activity Level
                    ShadowBoxList(
                      color: kCGBlue,
                      icon: SvgPicture.asset("assets/svgs/physical.svg",
                          width: 44),
                      // Icon(FontAwesomeIcons.hiking, color: kTextLightColor),
                      widgetColumn: <Widget>[
                        SizedBox(height: 10),
                        H2(
                            color: kTextLightColor,
                            textBody: _physicalActivityLevel == null
                                ? "Physical Activity Level: unset"
                                : "Physical Activity Level: " +
                                    _physicalActivityLevel.toShortString()),
                        SizedBox(height: 5),
                        BodyText(
                          textBody: "Tap to edit",
                          color: kTextLightColor,
                        ),
                        SizedBox(height: 10),
                      ],
                      onTapFunction: () {
                        Alert(
                            context: context,
                            title: "Edit Physical Activity Level",
                            closeIcon: Icon(
                              FontAwesomeIcons.timesCircle,
                              color: kPrimaryLightColor,
                            ),
                            style: AlertStyle(
                              overlayColor: Colors.black45,
                              titleStyle: H2TextStyle(color: kTextDarkColor),
                            ),
                            content: StatefulBuilder(
                              builder:
                                  (BuildContext context, StateSetter setState) {
                                return Column(
                                  children: <Widget>[
                                    SizedBox(height: 10),
                                    Column(
                                      children: <Widget>[
                                        Row(
                                          children: [
                                            Radio<PhysicalActivityLevel>(
                                              value: PhysicalActivityLevel
                                                  .Sedentary,
                                              groupValue:
                                                  _physicalActivityLevel,
                                              onChanged: (PhysicalActivityLevel
                                                  value) {
                                                setState(() {
                                                  _physicalActivityLevel =
                                                      value;
                                                  print(_physicalActivityLevel
                                                      .toShortString());
                                                });
                                              },
                                            ),
                                            H3(textBody: "Sedentary"),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Radio<PhysicalActivityLevel>(
                                              value:
                                                  PhysicalActivityLevel.Light,
                                              groupValue:
                                                  _physicalActivityLevel,
                                              onChanged: (PhysicalActivityLevel
                                                  value) {
                                                setState(() {
                                                  _physicalActivityLevel =
                                                      value;
                                                  print(_physicalActivityLevel
                                                      .toShortString());
                                                });
                                              },
                                            ),
                                            H3(textBody: "Light"),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Radio<PhysicalActivityLevel>(
                                              value: PhysicalActivityLevel
                                                  .Moderate,
                                              groupValue:
                                                  _physicalActivityLevel,
                                              onChanged: (PhysicalActivityLevel
                                                  value) {
                                                setState(() {
                                                  _physicalActivityLevel =
                                                      value;
                                                  print(_physicalActivityLevel
                                                      .toShortString());
                                                });
                                              },
                                            ),
                                            H3(textBody: "Moderate"),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Radio<PhysicalActivityLevel>(
                                              value: PhysicalActivityLevel
                                                  .Vigorous,
                                              groupValue:
                                                  _physicalActivityLevel,
                                              onChanged: (PhysicalActivityLevel
                                                  value) {
                                                setState(() {
                                                  _physicalActivityLevel =
                                                      value;
                                                  print(_physicalActivityLevel
                                                      .toShortString());
                                                });
                                              },
                                            ),
                                            H3(textBody: "Vigorous"),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 0,
                                    ),
                                  ],
                                );
                              },
                            ),
                            buttons: [
                              DialogButton(
                                margin: EdgeInsets.symmetric(horizontal: 20),
                                color: kPrimaryAccentColor,
                                height: 40,
                                child: Text("OK",
                                    style: TextStyle(color: kTextLightColor)),
                                onPressed: () {
                                  setState(() {});
                                  Navigator.pop(context);
                                },
                              ),
                            ]).show();
                      },
                    ),
                    SizedBox(height: 20),

                    //CalculateButton
                    ArgonButton(
                      height: 60,
                      width: 300,
                      roundLoadingShape: true,
                      child: Text("Calculate",
                          style: H1TextStyle(color: kTextLightColor)),
                      loader: Container(
                        padding: EdgeInsets.all(10),
                        child: SpinKitRotatingCircle(
                          color: kTextLightColor,
                        ),
                      ),
                      borderRadius: 12.0,
                      color: kActiveCardColour,
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 2.0,
                      ),
                      onTap: (startLoading, stopLoading, btnState) async {
                        if (btnState == ButtonState.Idle) {
                          startLoading();
                          String bmiResult = calculateBMI();
                          setBMIDescription();
                          Alert(
                              context: context,
                              title: "Intake Recommendation",
                              closeIcon: Icon(
                                FontAwesomeIcons.timesCircle,
                                color: kPrimaryLightColor,
                              ),
                              content: Container(
                                  height: 240,
                                  width: 300,
                                  child: Column(children: <Widget>[
                                    Divider(
                                      thickness: 1.5,
                                      color: Colors.black26,
                                    ),
                                    Spacer(),
                                    Text("On a daily basis, you burn: "),
                                    Spacer(),
                                    Text(
                                      bmiDescription + " calories",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold,
                                          color: kDarkAccentColor),
                                    ),
                                    Spacer(),
                                    Text("To lose, consume:"),
                                    Spacer(),
                                    Text(bmiType,
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: kDarkAccentColor)),
                                    Spacer(),
                                  ])),
                              style: AlertStyle(
                                animationType: AnimationType.fromBottom,
                                overlayColor: Colors.black45,
                                // isCloseButton: false,
                                isOverlayTapDismiss: false,
                                descStyle:
                                    TextStyle(fontWeight: FontWeight.bold),
                                descTextAlign: TextAlign.center,
                                animationDuration: Duration(milliseconds: 300),
                                alertBorder: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.0),
                                    side:
                                        BorderSide(color: Colors.transparent)),
                                titleStyle: TextStyle(
                                  color: kDarkAccentColor,
                                  fontWeight: FontWeight.bold,
                                ),
                                alertAlignment: Alignment.bottomCenter,
                              ),
                              buttons: [
                                DialogButton(
                                    width: 260,
                                    color: kActiveCardColour,
                                    onPressed: () => Navigator.pop(context),
                                    child: Text("Back",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20)))
                              ]).show();
                        }
                        stopLoading();
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
