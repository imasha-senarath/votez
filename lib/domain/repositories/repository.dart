import 'package:dartz/dartz.dart';
import 'package:votez/data/models/UserModel.dart';

import '../../core/error/failure.dart';

abstract class Repository {

  Future<Either<Failure, UserModel>> login(UserModel userModel);
}