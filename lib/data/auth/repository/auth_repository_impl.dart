import 'package:dartz/dartz.dart';
import 'package:other_screens/data/auth/models/user_creation_req.dart';
import 'package:other_screens/data/auth/source/auth_firebase_service.dart';
import 'package:other_screens/domain/auth/repository/auth.dart';
import 'package:other_screens/service_locator.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<Either> signup(UserCreationReq user) async {
    return await sl<AuthFirebaseService>().signup(user);
  }

  @override
  Future<Either> getAges() async {
    return await sl<AuthFirebaseService>().getAges();
  }
}
