import 'package:other_screens/data/auth/repository/auth_repository_impl.dart';
import 'package:other_screens/data/auth/source/auth_firebase_service.dart';
import 'package:other_screens/domain/auth/repository/auth.dart';
import 'package:other_screens/domain/auth/usecases/get_user.dart';
import 'package:other_screens/domain/auth/usecases/siginup.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Services

  sl.registerSingleton<AuthFirebaseService>(AuthFirebaseServiceImpl());

  // Repositories

  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());

  // Usecases

  sl.registerSingleton<SignupUseCase>(SignupUseCase());

  sl.registerSingleton<GetUserUseCase>(GetUserUseCase());
}
