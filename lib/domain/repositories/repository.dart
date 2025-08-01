import 'package:dartz/dartz.dart';
import 'package:votez/data/models/user_model.dart';

import '../../core/error/failure.dart';
import '../../models/poll.dart';
import '../../models/profile.dart';
import '../../models/vote.dart';

abstract class Repository {

  Future<Either<Failure, UserModel>> login(UserModel userModel);

  Future<Either<Failure, List<Profile>>> getProfiles();

  Future<Either<Failure, List<Poll>>> getPolls();

  Future<Either<Failure, List<Vote>>> getVotes();

  Future<Either<Failure, bool>> signOut();
}