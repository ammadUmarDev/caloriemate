class DairyItem {
  String itemID;
  String name;
  double quantity;
  double calories;
  String type;

  DairyItem({this.itemID,
    this.name,
    this.quantity,
    this.calories
  });

  // ignore: non_constant_identifier_names
  void print_dairyItem(){
    print(this.itemID);
    print(this.name);
    print(this.quantity);
    print(this.calories);
  }
}
