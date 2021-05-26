class CalorieModel {
  int calories;
  int quantity;
  CalorieModel({
    this.calories,
    this.quantity,
  });

  void printCalories() {
    print(this.calories);
    print(this.quantity);
  }

  // int getCalories() {
  //   if (calories != 0)
  //     return calories;
  //   else
  //     return -1;
  // }
}
