import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure([this.message = 'Something went wrong']);

  final String message;

  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure([super.message = 'Server error occurred']);
}

class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'Network error occurred']);
}

class InvalidCredentialsFailure extends Failure {
  const InvalidCredentialsFailure([super.message = 'Invalid email or password']);
}

class ValidationFailure extends Failure {
  const ValidationFailure([super.message = 'Validation failed']);
}