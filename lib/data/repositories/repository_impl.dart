import 'package:dartz/dartz.dart';

import 'package:votez/core/error/failure.dart';
import 'package:votez/models/profile.dart';

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
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Profile>>> getProfiles() async {
    try {
      final List<Map<String, dynamic>> fetchedData = await firebase.getData('Users');
      final List<Profile> profiles = fetchedData.map((data) => Profile.fromMap(data)).toList();
      return Right(profiles);
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}