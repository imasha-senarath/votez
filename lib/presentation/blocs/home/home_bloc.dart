import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_profiles_usecase.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetProfilesUseCase getProfilesUseCase;

  HomeBloc({required this.getProfilesUseCase}) : super(HomeStateInitial()) {
    on<GetProfilesEvent>(_getProfiles);
  }

  Future<void> _getProfiles(GetProfilesEvent event, Emitter<HomeState> emit) async {
    final result = await getProfilesUseCase();

    result.fold(
          (failure) => emit(GetProfilesFailedState(error: failure.message)),
          (profiles) => emit(GetProfilesSuccessState(profiles: profiles)),
    );
  }
}