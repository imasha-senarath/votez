
import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../models/vote.dart';
import '../repositories/repository.dart';

class GetPollVotesUseCase {
  final Repository repository;

  GetPollVotesUseCase(this.repository);

  Future<Either<Failure, List<Vote>>> call(String pollId) async {
    return await repository.getPollVotes(pollId);
  }
}