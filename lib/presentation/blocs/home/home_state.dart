import 'package:equatable/equatable.dart';
import '../../../models/profile.dart';

abstract class HomeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeStateInitial extends HomeState {}

class GetProfilesSuccessState extends HomeState {
  final List<Profile> profiles;

  GetProfilesSuccessState({required this.profiles});
}

class GetProfilesFailedState extends HomeState {
  final String error;

  GetProfilesFailedState({required this.error});
}