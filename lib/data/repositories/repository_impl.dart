import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:votez/core/error/failure.dart';

import 'package:votez/domain/entities/User.dart';

import '../../domain/repositories/repository.dart';
import '../datasources/firebase_service.dart';
import '../models/UserModel.dart';

class RepositoryImpl implements Repository {

  final FirebaseService firebase;

  RepositoryImpl({required this.firebase});

  @override
  Future<Either<Failure, UserModel>> login(UserModel userModel) async {
    try {

      final user = await firebase.loginUser(userModel);
      return Right(user!);

    } on Exception catch (e) {
      return const Left(InvalidCredentialsFailure());
    }
  }
}