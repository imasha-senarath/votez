import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:votez/domain/usecases/create_poll_usecase.dart';
import 'package:votez/presentation/blocs/poll/poll_event.dart';
import 'package:votez/presentation/blocs/poll/poll_state.dart';
import '../../../domain/usecases/get_user_id_usecase.dart';
import '../../../models/poll.dart';

class PollBloc extends Bloc<PollEvent, PollState> {
  final GetUserIdUseCase getUserIdUseCase;
  final CreatePollUseCase createPollUseCase;

  PollBloc({
    required this.getUserIdUseCase,
    required this.createPollUseCase,
  }) : super(PollInitialState()) {
    on<GeUserIdEvent>(_getUserId);
    on<CreatePollEvent>(_createPoll);
  }

  Future<void> _getUserId(GeUserIdEvent event, Emitter<PollState> emit) async {
    final result = await getUserIdUseCase();

    result.fold(
          (failure) => emit(GetUserIdFailedState(error: failure.message)),
          (id) => emit(GetUserIdSuccessState(userId: id)),
    );
  }

  Future<void> _createPoll(CreatePollEvent event, Emitter<PollState> emit) async {
    final result = await createPollUseCase(Poll(
      id: "",
      question: event.question,
      options: event.options,
      user: event.user,
    ));

    result.fold(
      (failure) => emit(CreatePollEventFailedState(error: failure.message)),
      (isCreated) => emit(CreatePollSuccessState()),
    );
  }
}
