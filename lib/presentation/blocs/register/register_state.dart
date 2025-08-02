import 'package:equatable/equatable.dart';

abstract class RegisterState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserRegisterInitialState extends RegisterState {}

class UserRegisterSuccessState extends RegisterState {}

class UserRegisterFailedState extends RegisterState {
  final String error;

  UserRegisterFailedState({required this.error});
}