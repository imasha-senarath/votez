import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/UserModel.dart';
import '../../../domain/usecases/get_users_usecase.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetUsersUseCase getUsersUseCase;

  HomeBloc({required this.getUsersUseCase}) : super(HomeStateInitial()) {
    on<GetUsersEvent>(_getUsers);
  }

  Future<void> _getUsers(GetUsersEvent event, Emitter<HomeState> emit) async {
    final result = await getUsersUseCase(UserModel(
      email: "event.email",
      password: "event.password",
    ));

    result.fold(
          (failure) => emit(GetUsersFailedState(error: failure.message)),
          (user) => emit(GetUsersSuccessState()),
    );
  }
}