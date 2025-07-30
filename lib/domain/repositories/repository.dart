import 'package:dartz/dartz.dart';
import 'package:votez/data/models/UserModel.dart';

import '../../core/error/failure.dart';
import '../../models/profile.dart';

abstract class Repository {

  Future<Either<Failure, UserModel>> login(UserModel userModel);

  Future<Either<Failure, List<Profile>>> getProfiles();
}