import 'diaryItem.dart';

class DiaryModel {
  String userID;
  DateTime date;
  List<DairyItem> Items;


  DiaryModel(
      {this.userID,
        this.Items});

  // ignore: non_constant_identifier_names
  void print_diary() {
    print(this.userID);

  }
}
