import 'package:calorie_mate/models/diaryData.dart';
import 'package:calorie_mate/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

FirebaseFirestore db = FirebaseFirestore.instance;
CollectionReference collection = db.collection('diaryLogs');

//
//
//
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

Stream<List<DiaryData>> getDiaryLogsByUserToday(String userId) {
  // List<DiaryData> diaryData = [];
  String dateNow = convertDateTimeDisplay(DateTime.now().toString());
  return collection
      .where("userId", isEqualTo: userId)
      .where("date", isEqualTo: dateNow)
      .snapshots()
      .map(
        (snapshot) => snapshot.docs.map(
          (doc) {
            return DiaryData.fromSnapshot(doc);
          },
        ).toList(),
      );
  // return diaryData;
}

Future<DocumentReference> createLog(DiaryData log) async {
  DocumentReference ref1 = db.collection("diaryLogs").doc();
  String docID = ref1.id;
  log.id = docID;

  await collection.doc(docID).set(log.toDocument());

  // DocumentReference ref = await collection.add(log.toDocument());

  return ref1;
}

Future<DocumentReference> deleteLog(String id) async {
  DocumentReference ref = collection.doc(id);
  await ref.delete();
  return ref;
}

Future<DocumentReference> updateLog(String id, DiaryData log) async {
  DocumentReference ref = collection.doc(id);
  await ref.update(log.toDocument());
  return ref;
}
