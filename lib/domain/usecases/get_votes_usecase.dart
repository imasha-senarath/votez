
import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../models/vote.dart';
import '../repositories/repository.dart';

class GetVotesUseCase {
  final Repository repository;

  GetVotesUseCase(this.repository);

  Future<Either<Failure, List<Vote>>> call() async {
    return await repository.getVotes();
  }
}