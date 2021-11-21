import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import '../../../models/food_calories.dart';

List<FoodCalories> parsePost(String responseBody) {
  var list = json.decode(responseBody) as List<dynamic>;
  var foods = list.map((model) => FoodCalories.fromJson(model)).toList();
  return foods;
}

Future<List<FoodCalories>> fetchData() async {
  // final response = await http.get(url)
}
