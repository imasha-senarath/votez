import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String? id;
  final String? email;
  final String? name;
  final String? password;

  UserModel( {
    this.id,
    this.name,
    this.email,
    this.password,
  });

  factory UserModel.fromFirebaseUser(User user) {
    return UserModel(
      id: user.uid,
      email: user.email ?? '',
    );
  }
}
