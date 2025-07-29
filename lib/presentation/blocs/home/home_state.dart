import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeStateInitial extends HomeState {}

class GetUsersSuccessState extends HomeState {}

class GetUsersFailedState extends HomeState {
  final String error;

  GetUsersFailedState({required this.error});
}