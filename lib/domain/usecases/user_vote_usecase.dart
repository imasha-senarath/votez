
import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../models/vote.dart';
import '../repositories/repository.dart';

class UserVoteUseCase {
  final Repository repository;

  UserVoteUseCase(this.repository);

  Future<Either<Failure, Vote>> call(Vote vote) async {
    return await repository.createVote(vote);
  }
}