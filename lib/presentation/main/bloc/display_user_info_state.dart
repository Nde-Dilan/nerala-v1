import 'package:other_screens/domain/auth/entities/user_entity.dart';

abstract class UserInfoDisplayState {}

class UserInfoLoading extends UserInfoDisplayState {}

class UserInfoLoaded extends UserInfoDisplayState {
  final UserEntity user;
  UserInfoLoaded({required this.user});
}

class LoadUserInfoFailure extends UserInfoDisplayState {}
