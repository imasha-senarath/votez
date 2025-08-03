import 'package:equatable/equatable.dart';

abstract class PollEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GeUserIdEvent extends PollEvent {}

class CreatePollEvent extends PollEvent {
  final String question;
  final List<String> options;
  final String user;

  CreatePollEvent({
    required this.question,
    required this.options,
    required this.user,
  });

  @override
  List<Object?> get props => [question, options, user];
}
