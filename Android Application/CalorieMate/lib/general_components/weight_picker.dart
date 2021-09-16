import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../constants.dart';

enum WeightUnit { kg, lbs }

class WeightPicker extends StatefulWidget {
  @override
  _WeightPickerState createState() => _WeightPickerState();
}

class _WeightPickerState extends State<WeightPicker> {
  WeightUnit SelectedUnitW = WeightUnit.kg;
  TextEditingController weightController = TextEditingController();
  var kg = 65;
  var lbs = 150;

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController1 = FixedExtentScrollController(initialItem: index1);
    scrollController2 = FixedExtentScrollController(initialItem: index2);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    scrollController1.dispose();
    scrollController2.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      height: 220,
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: kDarkAccentColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: <Widget>[
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
                  Icon(
                    // MaterialCommunityIcons.ruler,
                    FontAwesomeIcons.weight,
                    color: Colors.white,
                    size: 26,
                  ),
                ],
              ),
            ],
          ),
          Divider(
            color: Colors.white,
            height: 24,
            thickness: 3,
          ),
          Row(
            children: <Widget>[
              Container(
                width: 140,
                child: TextFormField(
                  onTap: SelectedUnitW == WeightUnit.kg
                      ? () {
                          FocusScope.of(context).requestFocus(new FocusNode());
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
                                          scrollController: scrollController1,
                                          itemExtent: 40.0,
                                          magnification: 1.3,
                                          squeeze: 1.3,
                                          selectionOverlay:
                                              CupertinoPickerDefaultSelectionOverlay(
                                            background:
                                                Colors.blue.withOpacity(0.2),
                                          ),
                                          onSelectedItemChanged: (int index) {
                                            print(index + 1);
                                            setState(() {
                                              kg = (index + 1);
                                              weightController.text = "$kg";
                                            });
                                          },
                                          children: List.generate(250, (index) {
                                            return Center(
                                              child: Text(
                                                '${index + 1}',
                                                style: TextStyle(
                                                  fontFamily: 'Montserrat',
                                                ),
                                              ),
                                            );
                                          }),
                                        ),
                                      ),
                                      Expanded(
                                          flex: 2,
                                          child: Center(
                                              child: Text('kg',
                                                  style: TextStyle(
                                                    decoration:
                                                        TextDecoration.none,
                                                    fontSize: 17,
                                                    fontFamily: 'Montserrat',
                                                    color: Colors.black87,
                                                  )))),
                                    ],
                                  ),
                                );
                              });
                        }
                      : () {
                          FocusScope.of(context).requestFocus(new FocusNode());
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
                                          scrollController: scrollController2,
                                          itemExtent: 40.0,
                                          magnification: 1.3,
                                          squeeze: 1.3,
                                          selectionOverlay:
                                              CupertinoPickerDefaultSelectionOverlay(
                                            background:
                                                Colors.blue.withOpacity(0.2),
                                          ),
                                          onSelectedItemChanged: (int index) {
                                            print(index + 1);
                                            setState(() {
                                              lbs = (index + 1);
                                              weightController.text = "$lbs";
                                            });
                                          },
                                          children: List.generate(450, (index) {
                                            return Center(
                                              child: Text(
                                                '${index + 1}',
                                                style: TextStyle(
                                                  fontFamily: 'Montserrat',
                                                ),
                                              ),
                                            );
                                          }),
                                        ),
                                      ),
                                      Expanded(
                                          flex: 1,
                                          child: Center(
                                              child: Text('lbs',
                                                  style: TextStyle(
                                                    decoration:
                                                        TextDecoration.none,
                                                    fontSize: 17,
                                                    fontFamily: 'Montserrat',
                                                    color: Colors.black87,
                                                  )))),
                                    ],
                                  ),
                                );
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
                      hintText: SelectedUnitW == WeightUnit.kg ? '-' : '-',
                      hintStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.8)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.8))),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp("[0-9.]"))
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
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
                      borderRadius: BorderRadius.circular(8),
                      color: SelectedUnitW == WeightUnit.kg
                          ? kActiveCardColour
                          : Colors.transparent,
                    ),
                    width: 50,
                    height: 50,
                    child: Center(
                        child: Text('kg',
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Montserrat',
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ))),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
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
                      borderRadius: BorderRadius.circular(8),
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
                              fontFamily: 'Montserrat',
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ))),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

//Reference: https://thatmandonald.medium.com/using-cupertinopicker-and-textfield-to-create-a-fancy-weight-picker-with-flutter-da03e990e9e5
