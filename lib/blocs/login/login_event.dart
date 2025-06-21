import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginPressed extends LoginEvent {
  final String email;
  final String password;

  LoginPressed({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}