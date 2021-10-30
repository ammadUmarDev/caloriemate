//Password Change
import 'dart:io';

import 'package:calorie_mate/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:validators/sanitizers.dart';
import 'package:calorie_mate/models/logDiary.dart';
import 'package:calorie_mate/models/diaryItem.dart';

//Check Internet Availability
Future<bool> internetCheck() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      print('Internet connected');
    }
  } on SocketException catch (_) {
    print('No internet connection');
    return false;
  }
  return true;
}

//User SignUp
Future<bool> signupFirebaseDb(UserModel user) async {
  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  bool internetCheckVar = await internetCheck();
  if (internetCheckVar == false)
    return false;
  else {
    await users.doc(user.userID).set({
      'User_Id': user.userID.toString(),
      'Full_Name': user.fullName.toString(),
      'Email': user.email.toString(),
      'Created_Date': user.createdDate.toString(),
      'Last_Pass_Change_Date': user.lastPassChangeDate.toString(),
      'Phone_Number': user.phoneNumber,
      'Age': user.age,
      'Gender': user.gender,
      'Height_Ft': user.heightFt,
      'Height_In': user.heightIn,
      'Current_Weight': user.currentWeight,
      'Targetted_Weight': user.targettedWeight,
      'Body_Goal': user.bodyGoal,
      'Physical_Activity_Level': user.physicalActivityLevel,
      'Latest_BMI': user.latestBMIScore,
      'Weight_History': user.weightHistory,
      'BMI_History': user.BMIHistory
      //    new DateFormat("dd/MM/yyyy").parse("11/11/2011");
    });
  }
  return true;
}

//User Password Change
Future<bool> changePassword(UserModel u, String enteredPass) async {
  User user = FirebaseAuth.instance.currentUser;
  await user.updatePassword(enteredPass).then((_) async {
    print("Succesfully changed auth password");
    return true;
  }).catchError((error) {
    print("Password can't be changed" + error.toString());
    return false;
    //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
  });
}

//User Name Change
Future<bool> changeFullName(UserModel u, String newName) async {
  FirebaseFirestore db = FirebaseFirestore.instance;
  CollectionReference users = db.collection('Users');
  bool check = false;
  await users
      .doc(u.userID)
      .update({'Full_Name': newName})
      .then((value) => check = true)
      .catchError((error) => print("Failed to update user: $error"));

  return check;
}

//User Phone Number Change
Future<bool> changePhoneNumber(UserModel u, String newPhoneNumber) async {
  FirebaseFirestore db = FirebaseFirestore.instance;
  CollectionReference users = db.collection('Users');
  bool check = false;
  await users
      .doc(u.userID)
      .update({'Phone_Number': newPhoneNumber})
      .then((value) => check = true)
      .catchError((error) => print("Failed to update user: $error"));

  return check;
}

//User Age Change
Future<bool> changeAge(UserModel u, int newAge) async {
  FirebaseFirestore db = FirebaseFirestore.instance;
  CollectionReference users = db.collection('Users');
  bool check = false;
  await users
      .doc(u.userID)
      .update({'Age': newAge})
      .then((value) => check = true)
      .catchError((error) => print("Failed to update user: $error"));

  return check;
}

//User Gender Change
Future<bool> changeGender(UserModel u, String newGender) async {
  FirebaseFirestore db = FirebaseFirestore.instance;
  CollectionReference users = db.collection('Users');
  bool check = false;
  await users
      .doc(u.userID)
      .update({'Gender': newGender})
      .then((value) => check = true)
      .catchError((error) => print("Failed to update user: $error"));

  return check;
}

//User Current Weight Change
Future<bool> changeCurrentWeight(UserModel u, double newCurrentWeight) async {
  FirebaseFirestore db = FirebaseFirestore.instance;
  CollectionReference users = db.collection('Users');
  bool check = false;
  await users
      .doc(u.userID)
      .update({'Current_Weight': newCurrentWeight})
      .then((value) => check = true)
      .catchError((error) => print("Failed to update user: $error"));

  return check;
}

//User Weight History Update
Future<bool> updateWeightHistory(
    UserModel u, List<double> newCurrentWeight) async {
  FirebaseFirestore db = FirebaseFirestore.instance;
  CollectionReference users = db.collection('Users');
  List<double> weightHist = [];
  weightHist = await getWeightHistory(u).onError((error, stackTrace) => []);
  weightHist.addAll(newCurrentWeight);
  // deleteWeightHistory(u);
  bool check = false;
  await users
      .doc(u.userID)
      .update({'Weight_History': weightHist})
      .then((value) => check = true)
      .catchError((error) => print("Failed to update user: $error"));

  return check;
}

//Appending weight history instead of union
Future<List<double>> getWeightHistory(UserModel u) async {
  FirebaseFirestore db = FirebaseFirestore.instance;
  CollectionReference users = db.collection('Users');
  List<double> weightHist = [];

  await users.doc(u.userID).get().then((value) {
    if (value == null) {
      return [];
    }
    List.from(value.data()["Weight_History"]).forEach((element) {
      weightHist.add(element);
    });
  });
  return weightHist;
}

//Appending weight history instead of union
List<double> getWeightHistory2(UserModel u)  {
  FirebaseFirestore db = FirebaseFirestore.instance;
  CollectionReference users = db.collection('Users');
  List<double> weightHist = [];

   users.doc(u.userID).get().then((value) {
    if (value == null) {
      return [];
    }
    List.from(value.data()["Weight_History"]).forEach((element) {
      weightHist.add(element);
    });
  });
  return weightHist;
}

//User Weight History Delete
Future<bool> deleteWeightHistory(UserModel u) async {
  FirebaseFirestore db = FirebaseFirestore.instance;
  CollectionReference users = db.collection('Users');
  bool check = false;
  await users
      .doc(u.userID)
      .update({'Weight_History': FieldValue.delete()})
      .then((value) => check = true)
      .catchError((error) => print("Failed to update user: $error"));

  return check;
}

//User Targetted Weight Change
Future<bool> changeTargettedWeight(
    UserModel u, double newTargettedWeight) async {
  FirebaseFirestore db = FirebaseFirestore.instance;
  CollectionReference users = db.collection('Users');
  bool check = false;
  await users
      .doc(u.userID)
      .update({'Targetted_Weight': newTargettedWeight})
      .then((value) => check = true)
      .catchError((error) => print("Failed to update user: $error"));

  return check;
}

//User Height Change
Future<bool> changeHeight(UserModel u, int newHeightFt, int newHeightIn) async {
  FirebaseFirestore db = FirebaseFirestore.instance;
  CollectionReference users = db.collection('Users');
  bool check = false;
  await users
      .doc(u.userID)
      .update({'Height_Ft': newHeightFt, 'Height_In': newHeightIn})
      .then((value) => check = true)
      .catchError((error) => print("Failed to update user: $error"));

  return check;
}

//User Physical Activity Level Change
Future<bool> changePhysicalActivityLevel(
    UserModel u, String newPhysicalActivityLevel) async {
  FirebaseFirestore db = FirebaseFirestore.instance;
  CollectionReference users = db.collection('Users');
  bool check = false;
  await users
      .doc(u.userID)
      .update({'Physical_Activity_Level': newPhysicalActivityLevel})
      .then((value) => check = true)
      .catchError((error) => print("Failed to update user: $error"));

  return check;
}

//get my diaries
Future<void> createDiaryLog(DiaryModel d, UserModel u)  {
  CollectionReference diaries = FirebaseFirestore.instance.collection('diaries');
  return diaries
      .add({
    'userID': u.userID,
    'date': DateTime.now(),
    'items': []
  })
      .then((value) => print("DiaryLog Added"))
      .catchError((error) => print("Failed to add DiaryLog: $error"));
}

//get my diaries
Future<bool> addDiaryLogItem(DairyItem d, UserModel u, String ID)  async {
  FirebaseFirestore db = FirebaseFirestore.instance;
  CollectionReference diaries = db.collection('diaries');
  List<DairyItem> logItems = [];
  logItems = await getDiarylogItems(ID).onError((error, stackTrace) => []);
  logItems.add(d);
  // deleteWeightHistory(u);
  bool check = false;
  await diaries
      .doc(ID)
      .update({'items': logItems})
      .then((value) => check = true)
      .catchError((error) => print("Failed to update diary: $error"));
  return check;
}
//Appending weight history instead of union
Future<List<DairyItem>> getDiarylogItems(String id) async {
  FirebaseFirestore db = FirebaseFirestore.instance;
  CollectionReference users = db.collection('diaries');
  List<DairyItem> logItems = [];

  await users.doc(id).get().then((value) {
    if (value == null) {
      return [];
    }
    List.from(value.data()["items"]).forEach((element) {
      logItems.add(element);
    });
  });
  return logItems;
}



