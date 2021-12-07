import 'dart:convert';

Workout foodCaloriesFromJson(String str) =>
    Workout.fromJson(json.decode(str));

String foodCaloriesToJson(Workout data) => json.encode(data.toJson());

class Workout {
  Workout({
    this.id,
    this.exercise,
    this.lb130,
    this.lb155,
    this.lb180,
    this.lb205,
    this.burnKg
  });

  int id;
  String exercise;
  int lb130;
  int lb155;
  int lb180;
  int lb205;
  double burnKg;

  factory Workout.fromJson(Map<String, dynamic> json) => Workout(
    id: json["id"],
    exercise: json["exercise"],
    lb130: json["lb130"],
    lb155: json["lb155"],
    lb180: json["lb180"],
    lb205: json["lb205"],
    burnKg: json["burnKg"],
  );

  Workout.fromJsonLocal(Map<String, dynamic> json) {
    id = json["id"];
    exercise = json["exercise"];
    lb130 = json["lb130"];
    lb155 = json["lb155"];
    lb180 = json["lb180"];
    lb205 = json["lb205"];
    burnKg: json["burnKg"];
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "exercise": exercise,
    "lb130": lb130,
    "lb155": lb155,
    "lb180": lb180,
    "burnKg": burnKg,
  };
}
