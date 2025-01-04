abstract class SignupWithGoogleState {}

class SignupWithGoogleInitial extends SignupWithGoogleState {}

class SignupWithGoogleLoading extends SignupWithGoogleState {}

class SignupWithGoogleSuccess extends SignupWithGoogleState {
  final String message;
  SignupWithGoogleSuccess(this.message);
}

class SignupWithGoogleError extends SignupWithGoogleState {
  final String error;
  SignupWithGoogleError(this.error);
}