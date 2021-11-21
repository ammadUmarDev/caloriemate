import 'package:calorie_mate/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DiaryData {
  String userId;
  String id;
  String name;
  String portion;
  String amount;
  String portionName;
  String calories;
  String date;
  TimeOfDay time;
  String type;

  DiaryData({
    this.userId,
    this.id,
    this.name,
    this.portion,
    this.amount,
    this.portionName,
    this.calories,
    this.date,
    this.time,
    this.type,
  });

  Map<String, Object> toDocument() {
    return {
      'userId': userId,
      'id': id,
      'name': name,
      'portion': portion,
      'amount': amount,
      'portionName': portionName,
      'calories': calories,
      'date': date,
      'time': Utils.formatTime(time),
      'type': type,
    };
  }

  DiaryData.fromSnapshot(DocumentSnapshot snap)
      : id = snap.id,
        userId = snap.data()['userId'],
        name = snap.data()['name'],
        portion = snap.data()['portion'],
        amount = snap.data()['amount'],
        portionName = snap.data()['portionName'],
        calories = snap.data()['calories'],
        date = snap.data()['date'],
        time = Utils.toTime(snap.data()['time']),
        type = snap.data()['type'];

  // ignore: non_constant_identifier_names
  void print_dairyItem() {
    print(this.id);
    print(this.name);
    print(this.amount);
    print(this.calories);
  }
}
