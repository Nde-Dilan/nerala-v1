class UserCreationReq {
  String ? firstName;
  String ? lastName;
  String ? email;
  String ? password;
  String ? goal;
  String ? dailyGoal;
  String ? learningLanguage;

  UserCreationReq({
      this.firstName,
      this.email,
      this.lastName,
      this.password,
      this.goal,
      this.dailyGoal,
      this.learningLanguage,
  });
}