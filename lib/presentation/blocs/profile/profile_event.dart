import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GeUserEvent extends ProfileEvent {
  final String userId;

  GeUserEvent({required this.userId});

  @override
  List<Object?> get props => [userId];
}

class SignOutEvent extends ProfileEvent {}