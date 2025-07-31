
import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../data/models/user_model.dart';
import '../../models/profile.dart';
import '../entities/User.dart';
import '../repositories/repository.dart';

class GetProfilesUseCase {
  final Repository repository;

  GetProfilesUseCase(this.repository);

  Future<Either<Failure, List<Profile>>> call() async {
    return await repository.getProfiles();
  }
}