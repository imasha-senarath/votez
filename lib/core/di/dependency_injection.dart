import 'package:get_it/get_it.dart';

import '../../data/datasources/firebase_service.dart';
import '../../data/repositories/repository_impl.dart';
import '../../domain/repositories/repository.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../presentation/blocs/login/login_bloc.dart';

final injection = GetIt.instance;

Future<void> init() async {

  injection.registerLazySingleton(() => FirebaseService());

  injection.registerLazySingleton<Repository>(() =>
      RepositoryImpl(firebase: injection()),
  );

  injection.registerLazySingleton(() =>
      LoginUseCase(injection())
  );

  injection.registerFactory(() =>
      LoginBloc(loginUseCase: injection()),
  );
}