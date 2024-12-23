class UserCreationReq {
  String ? firstName;
  String ? lastName;
  String ? email;
  String ? password;
  String ? goal;
  String ? dailyGoal;
  String ? learningLanguage;

  UserCreationReq({
    required this.firstName,
    required this.email,
    required this.lastName,
    required this.password,
    required this.goal,
    required this.dailyGoal,
    required this.learningLanguage,
  });
}