import 'package:equatable/equatable.dart';
import '../../../models/profile.dart';

abstract class SplashState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SplashStateInitial extends SplashState {}

class GetUserIdSuccessState extends SplashState {
  final String userId;

  GetUserIdSuccessState({required this.userId});
}

class GetUserIdFailedState extends SplashState {
  final String error;

  GetUserIdFailedState({required this.error});
}