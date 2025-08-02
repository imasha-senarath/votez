
import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../data/models/user_model.dart';
import '../entities/User.dart';
import '../repositories/repository.dart';

class RegisterUseCase {
  final Repository repository;

  RegisterUseCase(this.repository);

  Future<Either<Failure, UserModel>> call(UserModel userModel) async {
    return await repository.register(userModel);
  }
}