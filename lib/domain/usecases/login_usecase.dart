
import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../data/models/UserModel.dart';
import '../entities/User.dart';
import '../repositories/repository.dart';

class LoginUseCase {
  final Repository repository;

  LoginUseCase(this.repository);

  Future<Either<Failure, UserModel>> call(UserModel userModel) async {
    return await repository.login(userModel);
  }
}