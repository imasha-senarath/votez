import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:votez/domain/usecases/get_poll_votes_usecase.dart';
import 'package:votez/domain/usecases/user_vote_usecase.dart';
import 'package:votez/presentation/blocs/vote/vote_state.dart';
import 'package:votez/presentation/blocs/vote/vote_event.dart';
import '../../../domain/usecases/get_user_id_usecase.dart';
import '../../../models/vote.dart';

class VoteBloc extends Bloc<VoteEvent, VoteState> {
  final GetUserIdUseCase getUserIdUseCase;
  final GetPollVotesUseCase getPollVotesUseCase;
  final UserVoteUseCase userVoteUseCase;

  VoteBloc({
    required this.getUserIdUseCase,
    required this.getPollVotesUseCase,
    required this.userVoteUseCase,
  }) : super(VoteInitialState()) {
    on<GeUserIdEvent>(_getUserId);
    on<GetPollVotesEvent>(_getPollVotes);
    on<UserVoteEvent>(_userVote);
  }

  Future<void> _getUserId(GeUserIdEvent event, Emitter<VoteState> emit) async {
    final result = await getUserIdUseCase();

    result.fold(
      (failure) => emit(GetUserIdFailedState(error: failure.message)),
      (id) => emit(GetUserIdSuccessState(userId: id)),
    );
  }

  Future<void> _getPollVotes(GetPollVotesEvent event, Emitter<VoteState> emit) async {
    final result = await getPollVotesUseCase(event.pollId);

    result.fold(
          (failure) => emit(GetPollVotesFailedState(error: failure.message)),
          (votesList) => emit(GetPollVotesSuccessState(votes: votesList)),
    );
  }

  Future<void> _userVote(UserVoteEvent event, Emitter<VoteState> emit) async {
    final result = await userVoteUseCase(
      Vote(
        id: '',
        poll: event.poll,
        option: event.option,
        user: event.user,
      ),
    );

    result.fold(
      (failure) => emit(UserVoteFailedState(error: failure.message)),
      (isCreated) => emit(UserVoteSuccessState()),
    );
  }
}
