import 'package:equatable/equatable.dart';
import '../../../models/poll.dart';
import '../../../models/profile.dart';

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