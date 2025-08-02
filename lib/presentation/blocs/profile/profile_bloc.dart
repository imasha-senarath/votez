import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:votez/domain/usecases/get_user_usecase.dart';
import 'package:votez/presentation/blocs/profile/profile_event.dart';
import 'package:votez/presentation/blocs/profile/profile_state.dart';
import '../../../domain/usecases/sign_out_usecase.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetUserUseCase getUserUseCase;
  final SignOutUseCase signOutUseCase;

    ProfileBloc({
    required this.getUserUseCase,
    required this.signOutUseCase,
  }) : super(ProfileStateInitial()) {
    on<GeUserEvent>(_getUser);
    on<SignOutEvent>(_signOut);
  }

  Future<void> _getUser(GeUserEvent event, Emitter<ProfileState> emit) async {
    final result = await getUserUseCase(event.userId);

    result.fold(
          (failure) => emit(GetUserFailedState(error: failure.message)),
          (user) => emit(GetUserSuccessState(profile: user)),
    );
  }

  Future<void> _signOut(SignOutEvent event, Emitter<ProfileState> emit) async {
    final result = await signOutUseCase();

    result.fold(
          (failure) => emit(SignOutFailedState(error: failure.message)),
          (isSignedOut) => emit(SignOutSuccessState(result: isSignedOut)),
    );
  }
}
