import 'diaryItem.dart';

class DiaryModel {
  String userID;
  DateTime date;
  List<DairyItem> items;

  DiaryModel({this.userID, this.items});

  // ignore: non_constant_identifier_names
  void print_diary() {
    print(this.userID);
  }
}
