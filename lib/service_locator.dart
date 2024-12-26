import 'package:other_screens/data/auth/repository/auth_repository_impl.dart';
import 'package:other_screens/data/auth/source/auth_firebase_service.dart';
import 'package:other_screens/domain/auth/repository/auth.dart';
import 'package:other_screens/domain/auth/usecases/facebook_login.dart';
import 'package:other_screens/domain/auth/usecases/facebook_register.dart';
import 'package:other_screens/domain/auth/usecases/get_user.dart';
import 'package:other_screens/domain/auth/usecases/google_login.dart';
import 'package:other_screens/domain/auth/usecases/google_register.dart';
import 'package:other_screens/domain/auth/usecases/siginup.dart';
import 'package:get_it/get_it.dart';
import 'package:other_screens/domain/auth/usecases/signin.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Services

  sl.registerSingleton<AuthFirebaseService>(AuthFirebaseServiceImpl());

  // Repositories

  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());

  // Usecases
  sl.registerSingleton<SignupUseCase>(SignupUseCase());
  sl.registerSingleton<SigninUseCase>(SigninUseCase());
  sl.registerSingleton<GetUserUseCase>(GetUserUseCase());
  sl.registerSingleton<LoginWithGoogleUseCase>(LoginWithGoogleUseCase());
  sl.registerSingleton<LoginWithFacebookUseCase>(LoginWithFacebookUseCase());
  sl.registerSingleton<SignupWithGoogleUseCase>(SignupWithGoogleUseCase());
  sl.registerSingleton<SignupWithFacebookUseCase>(SignupWithFacebookUseCase());

}
