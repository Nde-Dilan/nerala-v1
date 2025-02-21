import 'package:dartz/dartz.dart';
import 'package:other_screens/core/usecase/usecase.dart';
import 'package:other_screens/domain/auth/repository/auth.dart';
import 'package:other_screens/domain/auth/usecases/no_params.dart';
import 'package:other_screens/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupWithGoogleUseCase implements UseCase<Either, NoParams> {
  @override
  Future<Either> call({NoParams? params}) async {
    final result = await sl<AuthRepository>().loginWithGoogle();

    if (result.isRight()) {
      // Set onboarding flag for new users
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('has_completed_onboarding', false);
    }

    return result;
  }
}
