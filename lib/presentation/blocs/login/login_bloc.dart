import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:votez/data/models/user_model.dart';

import '../../../domain/usecases/login_usecase.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;

  LoginBloc({required this.loginUseCase}) : super(LoginInitial()) {
    on<LoginPressed>(_onLoginPressed);
  }

  Future<void> _onLoginPressed(LoginPressed event, Emitter<LoginState> emit) async {
    final result = await loginUseCase(UserModel(
      email: event.email,
      password: event.password,
    ));

    result.fold(
          (failure) => emit(LoginFailure(error: failure.message)),
          (user) => emit(LoginSuccess()),
    );
  }
}