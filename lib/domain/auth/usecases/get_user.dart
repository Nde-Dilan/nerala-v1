import 'package:dartz/dartz.dart';
import 'package:other_screens/core/usecase/usecase.dart';
import 'package:other_screens/domain/auth/repository/auth.dart';
import 'package:other_screens/service_locator.dart';
class GetUserUseCase implements UseCase<Either,dynamic> {
  @override
  Future<Either> call({dynamic params}) async {
    return await sl<AuthRepository>().getUser();
  }
}