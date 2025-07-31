
import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../models/poll.dart';
import '../repositories/repository.dart';

class GetPollsUseCase {
  final Repository repository;

  GetPollsUseCase(this.repository);

  Future<Either<Failure, List<Poll>>> call() async {
    return await repository.getPolls();
  }
}