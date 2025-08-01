import 'package:dartz/dartz.dart';

import 'package:votez/core/error/failure.dart';
import 'package:votez/models/poll.dart';
import 'package:votez/models/profile.dart';
import 'package:votez/core/constants/app_constants.dart';
import 'package:votez/models/vote.dart';

import '../../domain/repositories/repository.dart';
import '../datasources/firebase_service.dart';
import '../models/user_model.dart';

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
      final List<Map<String, dynamic>> fetchedData = await firebase.getData(AppConstants.userCollection);
      final List<Profile> profiles = fetchedData.map((data) => Profile.fromMap(data)).toList();
      return Right(profiles);
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Poll>>> getPolls() async {
    try {
      final List<Map<String, dynamic>> fetchedData = await firebase.getData(AppConstants.pollCollection);
      final List<Poll> polls = fetchedData.map((data) => Poll.fromMap(data)).toList();
      return Right(polls);
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Vote>>> getVotes() async {
    try {
      final List<Map<String, dynamic>> fetchedData = await firebase.getData(AppConstants.voteCollection);
      final List<Vote> votes = fetchedData.map((data) => Vote.fromMap(data)).toList();
      return Right(votes);
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}