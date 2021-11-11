class CalorieModel {
  double calories;
  String name;
  CalorieModel({
    this.calories,
    this.name,
  });

  void printCalories() {
    print(this.calories);
    print(this.name);
  }

  // int getCalories() {
  //   if (calories != 0)
  //     return calories;
  //   else
  //     return -1;
  // }
}
