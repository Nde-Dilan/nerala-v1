import 'package:dartz/dartz.dart';
import 'package:other_screens/core/usecase/usecase.dart';
import 'package:other_screens/data/auth/models/user_creation_req.dart';
import 'package:other_screens/domain/auth/repository/auth.dart';
import 'package:other_screens/service_locator.dart';

class SignupUseCase implements UseCase<Either, UserCreationReq> {
  @override
  Future<Either> call({UserCreationReq? params}) async {
    return await sl<AuthRepository>().signup(params!);
  }
}
