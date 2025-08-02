import 'package:get_it/get_it.dart';
import 'package:votez/domain/usecases/get_polls_usecase.dart';
import 'package:votez/domain/usecases/get_profiles_usecase.dart';
import 'package:votez/domain/usecases/get_votes_usecase.dart';
import 'package:votez/domain/usecases/register_usecase.dart';
import 'package:votez/domain/usecases/sign_out_usecase.dart';
import 'package:votez/presentation/blocs/register/register_bloc.dart';

import '../../data/datasources/firebase_service.dart';
import '../../data/repositories/repository_impl.dart';
import '../../domain/repositories/repository.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../presentation/blocs/home/home_bloc.dart';
import '../../presentation/blocs/login/login_bloc.dart';

final injection = GetIt.instance;

Future<void> init() async {
  injection.registerLazySingleton(() => FirebaseService());

  injection.registerLazySingleton<Repository>(
    () => RepositoryImpl(firebase: injection()),
  );

  injection.registerLazySingleton(() => LoginUseCase(injection()));

  injection.registerFactory(
    () => LoginBloc(loginUseCase: injection()),
  );

  injection.registerLazySingleton(() => GetProfilesUseCase(injection()));

  injection.registerLazySingleton(() => GetPollsUseCase(injection()));

  injection.registerLazySingleton(() => GetVotesUseCase(injection()));

  injection.registerLazySingleton(() => SignOutUseCase(injection()));

  injection.registerFactory(
    () => HomeBloc(
      getProfilesUseCase: injection(),
      getPollsUseCase: injection(),
      getVotesUseCase: injection(),
      signOutUseCase: injection(),
    ),
  );

  injection.registerLazySingleton(() => RegisterUseCase(injection()));

  injection.registerFactory(
        () => RegisterBloc(registerUseCase: injection()),
  );
}
