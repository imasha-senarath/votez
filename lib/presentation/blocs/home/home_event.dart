import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetProfilesEvent extends HomeEvent {}

class GetPollsEvent extends HomeEvent {}

class GetVotesEvent extends HomeEvent {}

class SignOutEvent extends HomeEvent {}