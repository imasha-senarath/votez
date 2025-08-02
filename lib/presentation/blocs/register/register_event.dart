import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserRegisterEvent extends RegisterEvent {
  final String name;
  final String email;
  final String password;

  UserRegisterEvent({required this.name, required this.email, required this.password});

  @override
  List<Object?> get props => [name, email, password];
}