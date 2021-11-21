import 'package:calorie_mate/models/diaryData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

FirebaseFirestore db = FirebaseFirestore.instance;
CollectionReference collection = db.collection('diaryLogs');


// //get my diaries
// Future<void> createDiaryLog(DiaryModel d, UserModel u) {
//   CollectionReference diaries =
//       FirebaseFirestore.instance.collection('diaries');
//   return diaries
//       .add({'userID': u.userID, 'date': DateTime.now(), 'items': []})
//       .then((value) => print("DiaryLog Added"))
//       .catchError((error) => print("Failed to add DiaryLog: $error"));
// }

// //get my diaries
// Future<bool> addDiaryLogItem(DairyItem d, UserModel u, String ID) async {
//   FirebaseFirestore db = FirebaseFirestore.instance;
//   CollectionReference diaries = db.collection('diaries');
//   List<DairyItem> logItems = [];
//   logItems = await getDiarylogItems(ID).onError((error, stackTrace) => []);
//   logItems.add(d);
//   // deleteWeightHistory(u);
//   bool check = false;
//   await diaries
//       .doc(ID)
//       .update({'items': logItems})
//       .then((value) => check = true)
//       .catchError((error) => print("Failed to update diary: $error"));
//   return check;
// }

// //Appending weight history instead of union
// Future<List<DairyItem>> getDiarylogItems(String id) async {
//   FirebaseFirestore db = FirebaseFirestore.instance;
//   CollectionReference users = db.collection('diaries');
//   List<DairyItem> logItems = [];

//   await users.doc(id).get().then((value) {
//     if (value == null) {
//       return [];
//     }
//     List.from(value.data()["items"]).forEach((element) {
//       logItems.add(element);
//     });
//   });
//   return logItems;
// }


Stream<List<DiaryData>> getDiaryLogsByUser(String userId) {
  return collection.where("userId", isEqualTo: userId).snapshots().map(
        (snapshot) => snapshot.docs.map(
          (doc) {
            return DiaryData.fromSnapshot(doc);
          },
        ).toList(),
      );
}

String convertDateTimeDisplay(String date) {
  final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
  final DateFormat serverFormater = DateFormat('dd-MM-yyyy');
  final DateTime displayDate = displayFormater.parse(date);
  final String formatted = serverFormater.format(displayDate);
  return formatted;
}

List<DiaryData> getDiaryLogsByUserToday(String userId) {
  List<DiaryData> diaryData = [];
  collection.where("userId", isEqualTo: userId).snapshots().map(
        (snapshot) => snapshot.docs.map(
          (doc) {
            return DiaryData.fromSnapshot(doc);
          },
        ).toList(),
      );
  return diaryData;
}

Future<DocumentReference> createLog(DiaryData log) async {
  DocumentReference ref = await collection.add(log.toDocument());
  return ref;
}

Future<DocumentReference> deleteLog(String id) async {
  DocumentReference ref = collection.doc(id);
  await ref.delete();
  return ref;
}

Future<DocumentReference> updateLog(String id, DiaryData task) async {
  DocumentReference ref = collection.doc(id);
  await ref.update(task.toDocument());
  return ref;
}
