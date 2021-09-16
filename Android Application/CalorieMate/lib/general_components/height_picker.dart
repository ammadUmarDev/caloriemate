import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../constants.dart';

enum HeightUnit { ft, cm }

class HeightPicker extends StatefulWidget {
  @override
  _HeightPickerState createState() => _HeightPickerState();
}

class _HeightPickerState extends State<HeightPicker> {
  HeightUnit selectedUnit = HeightUnit.ft;
  TextEditingController heightController = TextEditingController();
  int ft = 5;
  int inches = 0;
  // String cm;
  int cm;
  int height;
  int index = 4;
  int index4 = 169;
  FixedExtentScrollController scrollController;
  FixedExtentScrollController scrollController4;

  // cmToInches(inchess) {
  //   ft = inchess ~/ 12;
  //   inches = inchess % 12;
  //   print('$ft feet and $inches inches');
  // }

  // inchesToCm() {
  //   int inchesTotal = (ft * 12) + inches;
  //   cm = (inchesTotal * 2.54).toInt();
  //   heightController.text = cm.toString();
  // }

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
        int inchess = (double.parse(heightController.text) ~/ 2.54).toInt();
        // cmToInches(inchess);
        heightController.text = '$ft\' $inches"';
      });
    } else if (selectedUnit == HeightUnit.cm) {
      setState(() {
        heightController.text = '__';
        print(heightController.text);
        // inchesToCm();
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController = FixedExtentScrollController(initialItem: index);
    scrollController4 = FixedExtentScrollController(initialItem: index4);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    scrollController.dispose();
    scrollController4.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    "Height",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(width: 5),
                  Icon(
                    // MaterialCommunityIcons.ruler,
                    FontAwesomeIcons.rulerVertical,
                    color: Colors.white,
                    size: 30,
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
                width: 160,
                child: TextFormField(
                  onTap: selectedUnit == HeightUnit.ft
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
                                          scrollController: scrollController,
                                          itemExtent: 64.0,
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
                                              ft = (index + 1);
                                              heightController.text =
                                                  "$ft' $inches\"";
                                            });
                                          },
                                          children: List.generate(12, (index) {
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
                                              child: Text('ft',
                                                  style: TextStyle(
                                                    decoration:
                                                        TextDecoration.none,
                                                    fontSize: 17,
                                                    fontFamily: 'Montserrat',
                                                    color: Colors.black87,
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
                                            background:
                                                Colors.blue.withOpacity(0.2),
                                          ),
                                          onSelectedItemChanged: (int index) {
                                            print(index);
                                            setState(() {
                                              inches = (index);
                                              heightController.text =
                                                  "$ft' $inches\"";
                                              height = feetToCm();
                                            });
                                          },
                                          children: List.generate(12, (index) {
                                            return Center(
                                              child: Text(
                                                '$index',
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
                                            child: Text('inches',
                                                style: TextStyle(
                                                  decoration:
                                                      TextDecoration.none,
                                                  fontSize: 17,
                                                  fontFamily: 'Montserrat',
                                                  color: Colors.black87,
                                                ))),
                                      )
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
                                          scrollController: scrollController4,
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
                                              cm = (index + 1);
                                              heightController.text = "$cm";
                                              height = cm;
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
                                              child: Text('cm',
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
                  controller: heightController,
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
                          selectedUnit == HeightUnit.ft ? "__' __\"" : '__',
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
              SizedBox(width: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
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
                              fontFamily: 'Montserrat',
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ))),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

//Reference: https://thatmandonald.medium.com/using-cupertinopicker-and-textfield-to-create-a-fancy-height-picker-with-flutter-da03e990e9e5
