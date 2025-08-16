import 'package:equatable/equatable.dart';

abstract class VoteEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GeUserIdEvent extends VoteEvent {}

class GetPollVotesEvent extends VoteEvent {
  final String pollId;

  GetPollVotesEvent({required this.pollId});

  @override
  List<Object?> get props => [pollId];
}

class UserVoteEvent extends VoteEvent {
  final String poll;
  final int option;
  final String user;

  UserVoteEvent({
    required this.poll,
    required this.option,
    required this.user,
  });

  @override
  List<Object?> get props => [poll, option, user];
}
