
import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../data/models/user_model.dart';
import '../entities/User.dart';
import '../repositories/repository.dart';

class SignOutUseCase {
  final Repository repository;

  SignOutUseCase(this.repository);

  Future<Either<Failure, bool>> call() async {
    return await repository.signOut();
  }
}