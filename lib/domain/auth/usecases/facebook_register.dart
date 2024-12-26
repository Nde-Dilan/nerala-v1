import 'package:dartz/dartz.dart';
import 'package:other_screens/core/usecase/usecase.dart';
import 'package:other_screens/domain/auth/repository/auth.dart';
import 'package:other_screens/domain/auth/usecases/no_params.dart';
import 'package:other_screens/service_locator.dart';

class SignupWithFacebookUseCase implements UseCase<Either, NoParams> {
  @override
  Future<Either> call({NoParams? params}) async {
    return sl<AuthRepository>().signupWithFacebook();
  }
}