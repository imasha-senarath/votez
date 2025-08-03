import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:votez/domain/usecases/get_user_id_usecase.dart';
import 'package:votez/domain/usecases/get_user_usecase.dart';
import 'package:votez/presentation/blocs/profile/profile_event.dart';
import 'package:votez/presentation/blocs/profile/profile_state.dart';
import 'package:votez/presentation/blocs/splash/splash_event.dart';
import 'package:votez/presentation/blocs/splash/splash_state.dart';
import '../../../domain/usecases/sign_out_usecase.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final GetUserIdUseCase getUserIdUseCase;

  SplashBloc({
    required this.getUserIdUseCase,
  }) : super(SplashStateInitial()) {
    on<GeUserIdEvent>(_getUserId);
  }

  Future<void> _getUserId(GeUserIdEvent event, Emitter<SplashState> emit) async {
    final result = await getUserIdUseCase();

    result.fold(
      (failure) => emit(GetUserIdFailedState(error: failure.message)),
      (id) => emit(GetUserIdSuccessState(userId: id)),
    );
  }
}
