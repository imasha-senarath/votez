
import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../data/models/user_model.dart';
import '../entities/User.dart';
import '../repositories/repository.dart';

class GetUserIdUseCase {
  final Repository repository;

  GetUserIdUseCase(this.repository);

  Future<Either<Failure, String>> call() async {
    return await repository.getUserId();
  }
}