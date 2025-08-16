import 'package:equatable/equatable.dart';

import '../../../models/vote.dart';

abstract class VoteState extends Equatable {
  @override
  List<Object?> get props => [];
}

class VoteInitialState extends VoteState {}

class GetUserIdSuccessState extends VoteState {
  final String userId;

  GetUserIdSuccessState({required this.userId});
}

class GetUserIdFailedState extends VoteState {
  final String error;

  GetUserIdFailedState({required this.error});
}

class GetPollVotesSuccessState extends VoteState {
  final List<Vote> votes;

  GetPollVotesSuccessState({required this.votes});
}

class GetPollVotesFailedState extends VoteState {
  final String error;

  GetPollVotesFailedState({required this.error});
}

class UserVoteSuccessState extends VoteState {}

class UserVoteFailedState extends VoteState {
  final String error;

  UserVoteFailedState({required this.error});
}