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
  Future<Either<Failure, bool>> login(UserModel userModel) async {
    try {

      //final userModel = await firebase.loginUser(userModel);
      return const Right(true);

      /*await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );

      final userModel = await authDataSource.login(user);
      return Right(userModel);*/
    } on Exception catch (e) {
      if (e.toString().contains('Invalid credentials')) {
        return const Left(InvalidCredentialsFailure());
      } else {
        return const Left(ServerFailure());
      }
    }
  }
  
}