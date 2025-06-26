import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? id;
  final String email;
  final String? name;
  final String? password; // For login purposes

  const User({
    this.id,
    required this.email,
    this.name,
    this.password,
  });

  // Constructor for login (with email and password)
  const User.forLogin({
    required this.email,
    required this.password,
  }) : id = null, name = null;

  // Constructor for authenticated user (with id, email, name)
  const User.authenticated({
    required this.id,
    required this.email,
    required this.name,
  }) : password = null;

  @override
  List<Object?> get props => [id, email, name, password];
}