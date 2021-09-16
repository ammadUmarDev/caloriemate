import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../constants.dart';

class AgePicker extends StatefulWidget {
  @override
  _AgePickerState createState() => _AgePickerState();
}

class _AgePickerState extends State<AgePicker> {
  TextEditingController ageController = TextEditingController();
  var age = 20;

  int index3 = 20;

  FixedExtentScrollController scrollController3;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController3 = FixedExtentScrollController(initialItem: index3);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    scrollController3.dispose();

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
                    "Age",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(width: 5),
                  Icon(
                    // MaterialCommunityIcons.,
                    FontAwesomeIcons.solidCalendar,
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
                width: 140,
                child: TextFormField(
                  onTap: () {
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
                                    scrollController: scrollController3,
                                    itemExtent: 40.0,
                                    magnification: 1.3,
                                    squeeze: 1.3,
                                    selectionOverlay:
                                        CupertinoPickerDefaultSelectionOverlay(
                                      background: Colors.blue.withOpacity(0.2),
                                    ),
                                    onSelectedItemChanged: (int index) {
                                      print(index + 1);
                                      setState(() {
                                        age = (index + 1);
                                        ageController.text = "$age";
                                      });
                                    },
                                    children: List.generate(120, (index) {
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
                                        child: Text('Age',
                                            style: TextStyle(
                                              decoration: TextDecoration.none,
                                              fontSize: 17,
                                              fontFamily: 'Montserrat',
                                              color: Colors.black87,
                                            )))),
                              ],
                            ),
                          );
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
        ],
      ),
    );
  }
}
