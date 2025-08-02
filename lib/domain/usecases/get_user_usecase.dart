
import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../models/profile.dart';
import '../repositories/repository.dart';

class GetUserUseCase {
  final Repository repository;

  GetUserUseCase(this.repository);

  Future<Either<Failure, Profile>> call(String userId) async {
    return await repository.getUser(userId);
  }
}