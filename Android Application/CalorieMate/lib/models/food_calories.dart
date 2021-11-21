// To parse this JSON data, do
//
//     final foodCalories = foodCaloriesFromJson(jsonString);

import 'dart:convert';

FoodCalories foodCaloriesFromJson(String str) =>
    FoodCalories.fromJson(json.decode(str));

String foodCaloriesToJson(FoodCalories data) => json.encode(data.toJson());

class FoodCalories {
  FoodCalories({
    this.id,
    this.name,
    this.portion,
    this.amount,
    this.portionName,
    this.calories,
  });

  String id;
  String name;
  String portion;
  String amount;
  String portionName;
  String calories;

  factory FoodCalories.fromJson(Map<String, dynamic> json) => FoodCalories(
        id: json["id"],
        name: json["name"],
        portion: json["portion"],
        amount: json["amount"],
        portionName: json["portion_name"],
        calories: json["calories"],
      );

  FoodCalories.fromJsonLocal(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    portion = json["portion"];
    amount = json["amount"];
    portionName = json["portion_name"];
    calories = json["calories"];
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "portion": portion,
        "amount": amount,
        "portion_name": portionName,
        "calories": calories,
      };
}
