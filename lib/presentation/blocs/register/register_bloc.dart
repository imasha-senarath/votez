import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:votez/domain/usecases/register_usecase.dart';
import 'package:votez/presentation/blocs/register/register_event.dart';
import 'package:votez/presentation/blocs/register/register_state.dart';
import '../../../data/models/user_model.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUseCase registerUseCase;

  RegisterBloc({
    required this.registerUseCase,
  }) : super(UserRegisterInitialState()) {
    on<UserRegisterEvent>(_userRegister);
  }

  Future<void> _userRegister(UserRegisterEvent event, Emitter<RegisterState> emit) async {
    final result = await registerUseCase(UserModel(
      name: event.name,
      email: event.email,
      password: event.password,
    ));

    result.fold(
          (failure) => emit(UserRegisterFailedState(error: failure.message)),
          (user) => emit(UserRegisterSuccessState()),
    );
  }
}
