import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:votez/data/models/user_model.dart';

import '../../../domain/usecases/login_usecase.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;

  LoginBloc({required this.loginUseCase}) : super(UserLoginInitialState()) {
    on<UserLoginEvent>(_onLoginPressed);
  }

  Future<void> _onLoginPressed(UserLoginEvent event, Emitter<LoginState> emit) async {
    final result = await loginUseCase(UserModel(
      email: event.email,
      password: event.password,
    ));

    result.fold(
          (failure) => emit(UserLoginFailedState(error: failure.message)),
          (user) => emit(UserLoginSuccessState()),
    );
  }
}