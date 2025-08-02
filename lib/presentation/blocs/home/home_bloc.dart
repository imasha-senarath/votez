import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:votez/domain/usecases/get_polls_usecase.dart';
import 'package:votez/domain/usecases/get_votes_usecase.dart';

import '../../../domain/usecases/get_profiles_usecase.dart';
import '../../../domain/usecases/sign_out_usecase.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetProfilesUseCase getProfilesUseCase;
  final GetPollsUseCase getPollsUseCase;
  final GetVotesUseCase getVotesUseCase;

  HomeBloc({
    required this.getProfilesUseCase,
    required this.getPollsUseCase,
    required this.getVotesUseCase,
  }) : super(HomeStateInitial()) {
    on<GetProfilesEvent>(_getProfiles);
    on<GetPollsEvent>(_getPolls);
    on<GetVotesEvent>(_getVotes);
  }

  Future<void> _getProfiles(GetProfilesEvent event, Emitter<HomeState> emit) async {
    final result = await getProfilesUseCase();

    result.fold(
          (failure) => emit(GetProfilesFailedState(error: failure.message)),
          (profileList) => emit(GetProfilesSuccessState(profiles: profileList)),
    );
  }

  Future<void> _getPolls(GetPollsEvent event, Emitter<HomeState> emit) async {
    final result = await getPollsUseCase();

    result.fold(
          (failure) => emit(GetPollsFailedState(error: failure.message)),
          (pollList) => emit(GetPollsSuccessState(polls: pollList)),
    );
  }

  Future<void> _getVotes(GetVotesEvent event, Emitter<HomeState> emit) async {
    final result = await getVotesUseCase();

    result.fold(
          (failure) => emit(GetVotesFailedState(error: failure.message)),
          (votesList) => emit(GetVotesSuccessState(votes: votesList)),
    );
  }
}
