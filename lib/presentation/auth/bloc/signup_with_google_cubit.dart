import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:other_screens/domain/auth/usecases/google_register.dart'; 
import 'package:other_screens/presentation/auth/bloc/signup_with_google.dart';
import 'package:other_screens/service_locator.dart';

class SignupWithGoogleCubit extends Cubit<SignupWithGoogleState> {
  SignupWithGoogleCubit() : super(SignupWithGoogleInitial());

  Future<void> signUpWithGoogle() async {
    emit(SignupWithGoogleLoading());
    try {
      final result = await sl<SignupWithGoogleUseCase>().call();
      
      result.fold(
        (failure) => emit(SignupWithGoogleError(failure.toString())),
        (success) => emit(SignupWithGoogleSuccess(success.toString())),
      );
    } catch (e) {
      emit(SignupWithGoogleError(e.toString()));
    }
  }
}