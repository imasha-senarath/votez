import 'package:dartz/dartz.dart';
import 'package:votez/data/models/UserModel.dart';

import '../../core/error/failure.dart';
import '../entities/User.dart';

abstract class Repository {

  Future<Either<Failure, bool>> login(UserModel userModel);
}