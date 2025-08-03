import 'package:equatable/equatable.dart';

abstract class PollState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PollInitialState extends PollState {}

class GetUserIdSuccessState extends PollState {
  final String userId;

  GetUserIdSuccessState({required this.userId});
}

class GetUserIdFailedState extends PollState {
  final String error;

  GetUserIdFailedState({required this.error});
}

class CreatePollSuccessState extends PollState {}

class CreatePollEventFailedState extends PollState {
  final String error;

  CreatePollEventFailedState({required this.error});
}