import 'package:get_it/get_it.dart';
import 'package:votez/domain/usecases/create_poll_usecase.dart';
import 'package:votez/domain/usecases/get_polls_usecase.dart';
import 'package:votez/domain/usecases/get_profiles_usecase.dart';
import 'package:votez/domain/usecases/get_user_id_usecase.dart';
import 'package:votez/domain/usecases/get_user_usecase.dart';
import 'package:votez/domain/usecases/get_votes_usecase.dart';
import 'package:votez/domain/usecases/register_usecase.dart';
import 'package:votez/domain/usecases/sign_out_usecase.dart';
import 'package:votez/presentation/blocs/poll/poll_bloc.dart';
import 'package:votez/presentation/blocs/profile/profile_bloc.dart';
import 'package:votez/presentation/blocs/register/register_bloc.dart';
import 'package:votez/presentation/blocs/splash/splash_bloc.dart';
import 'package:votez/presentation/blocs/vote/vote_bloc.dart';

import '../../data/datasources/firebase_service.dart';
import '../../data/repositories/repository_impl.dart';
import '../../domain/repositories/repository.dart';
import '../../domain/usecases/get_poll_votes_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/user_vote_usecase.dart';
import '../../presentation/blocs/home/home_bloc.dart';
import '../../presentation/blocs/login/login_bloc.dart';

final injection = GetIt.instance;

Future<void> init() async {
  injection.registerLazySingleton(() => FirebaseService());

  injection.registerLazySingleton<Repository>(
    () => RepositoryImpl(firebase: injection()),
  );

  injection.registerLazySingleton(() => LoginUseCase(injection()));

  injection.registerLazySingleton(() => GetProfilesUseCase(injection()));

  injection.registerLazySingleton(() => GetPollsUseCase(injection()));

  injection.registerLazySingleton(() => GetVotesUseCase(injection()));

  injection.registerLazySingleton(() => SignOutUseCase(injection()));

  injection.registerLazySingleton(() => RegisterUseCase(injection()));

  injection.registerLazySingleton(() => GetUserUseCase(injection()));

  injection.registerLazySingleton(() => GetUserIdUseCase(injection()));

  injection.registerLazySingleton(() => CreatePollUseCase(injection()));

  injection.registerLazySingleton(() => UserVoteUseCase(injection()));

  injection.registerLazySingleton(() => GetPollVotesUseCase(injection()));

  injection.registerFactory(
    () => LoginBloc(
      loginUseCase: injection(),
    ),
  );

  injection.registerFactory(
    () => HomeBloc(
      getUserIdUseCase: injection(),
      getProfilesUseCase: injection(),
      getPollsUseCase: injection(),
      getVotesUseCase: injection(),
    ),
  );

  injection.registerFactory(
    () => RegisterBloc(
      registerUseCase: injection(),
    ),
  );

  injection.registerFactory(
    () => ProfileBloc(
      getUserIdUseCase: injection(),
      getUserUseCase: injection(),
      signOutUseCase: injection(),
    ),
  );

  injection.registerFactory(
    () => SplashBloc(
      getUserIdUseCase: injection(),
    ),
  );

  injection.registerFactory(
    () => PollBloc(
      getUserIdUseCase: injection(),
      createPollUseCase: injection(),
    ),
  );

  injection.registerFactory(
    () => VoteBloc(
      getUserIdUseCase: injection(),
      getPollVotesUseCase: injection(),
      userVoteUseCase: injection(),
    ),
  );
}
