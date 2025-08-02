import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserLoginInitialState extends LoginState {}

class UserLoginSuccessState extends LoginState {}

class UserLoginFailedState extends LoginState {
  final String error;

  UserLoginFailedState({required this.error});
}