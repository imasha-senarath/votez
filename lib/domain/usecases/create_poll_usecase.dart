
import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../models/poll.dart';
import '../repositories/repository.dart';

class CreatePollUseCase {
  final Repository repository;

  CreatePollUseCase(this.repository);

  Future<Either<Failure, Poll>> call(Poll poll) async {
    return await repository.createPoll(poll);
  }
}