import 'package:equatable/equatable.dart';
import '../../../models/profile.dart';

abstract class ProfileState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProfileStateInitial extends ProfileState {}

class GetUserIdSuccessState extends ProfileState {
  final String userId;

  GetUserIdSuccessState({required this.userId});
}

class GetUserIdFailedState extends ProfileState {
  final String error;

  GetUserIdFailedState({required this.error});
}

class GetUserSuccessState extends ProfileState {
  final Profile profile;

  GetUserSuccessState({required this.profile});
}

class GetUserFailedState extends ProfileState {
  final String error;

  GetUserFailedState({required this.error});
}

class SignOutSuccessState extends ProfileState {
  final bool result;

  SignOutSuccessState({required this.result});
}

class SignOutFailedState extends ProfileState {
  final String error;

  SignOutFailedState({required this.error});
}