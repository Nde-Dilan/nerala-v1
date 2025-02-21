import 'package:dartz/dartz.dart';
import 'package:other_screens/data/auth/models/user_creation_req.dart';
import 'package:other_screens/data/auth/models/user_signin_req.dart';

abstract class AuthRepository {
  Future<Either> signup(UserCreationReq user);
  Future<Either> signin(UserSigninReq user);
  Future<Either> logout( );

  Future<Either> loginWithGoogle();
  Future<Either> loginWithFacebook();

  Future<Either> signupWithGoogle();
  Future<Either> signupWithFacebook();

  Future<bool> isLoggedIn();
  Future<Either> getUser();
}
