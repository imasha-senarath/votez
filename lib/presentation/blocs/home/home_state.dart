import 'package:equatable/equatable.dart';
import '../../../models/poll.dart';
import '../../../models/profile.dart';
import '../../../models/vote.dart';

abstract class HomeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeStateInitial extends HomeState {}

class GetProfilesSuccessState extends HomeState {
  final List<Profile> profiles;

  GetProfilesSuccessState({required this.profiles});
}

class GetProfilesFailedState extends HomeState {
  final String error;

  GetProfilesFailedState({required this.error});
}

class GetPollsSuccessState extends HomeState {
  final List<Poll> polls;

  GetPollsSuccessState({required this.polls});
}

class GetPollsFailedState extends HomeState {
  final String error;

  GetPollsFailedState({required this.error});
}

class GetVotesSuccessState extends HomeState {
  final List<Vote> votes;

  GetVotesSuccessState({required this.votes});
}

class GetVotesFailedState extends HomeState {
  final String error;

  GetVotesFailedState({required this.error});
}

class SignOutSuccessState extends HomeState {
  final bool result;

  SignOutSuccessState({required this.result});
}

class SignOutFailedState extends HomeState {
  final String error;

  SignOutFailedState({required this.error});
}