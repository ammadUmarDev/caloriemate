class UserModel {
  String userID;
  String fullName;
  String email;
  String createdDate;
  String lastPassChangeDate;
  String phoneNumber;
  int age;
  String gender;
  int heightFt;
  int heightIn;
  double currentWeight;
  double targettedWeight;
  String bodyGoal;
  String physicalActivityLevel;
  double latestBMIScore;
  List<double> weightHistory;
  List<double> BMIHistory;


  UserModel({this.userID,
    this.fullName,
    this.email,
    this.createdDate,
    this.lastPassChangeDate,
    this.phoneNumber,
    this.age,
    this.gender,
    this.heightFt,
    this.heightIn,
    this.currentWeight,
    this.targettedWeight,
    this.bodyGoal,
    this.physicalActivityLevel,
    this.latestBMIScore,
    this.weightHistory,
    this.BMIHistory
  });

  // ignore: non_constant_identifier_names
  void print_user() {
    print(this.userID);
    print(this.fullName);
    print(this.email);
    print(this.createdDate);
    print(this.phoneNumber);
    print(this.age);
    print(this.gender);
    print(this.heightFt);
    print(this.heightIn);
    print(this.currentWeight);
    print(this.targettedWeight);
    print(this.bodyGoal);
    print(this.physicalActivityLevel);
    print(this.latestBMIScore);
  }
}
