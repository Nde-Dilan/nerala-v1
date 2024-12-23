import 'package:dartz/dartz.dart';
import 'package:other_screens/core/usecase/usecase.dart';
import 'package:other_screens/data/auth/models/user_signin_req.dart';
import 'package:other_screens/domain/auth/repository/auth.dart';
import 'package:other_screens/service_locator.dart';

class SigninUseCase implements UseCase<Either,UserSigninReq> {

  @override
  Future<Either> call({UserSigninReq ? params}) async {
    return sl<AuthRepository>().signin(params!);
  }

}