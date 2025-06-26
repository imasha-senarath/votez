
import '../../domain/entities/User.dart';

class UserModel extends User {
  const UserModel({
    super.id,
    required super.email,
    super.name,
    super.password,
  });

  // Constructor for login
  const UserModel.forLogin({
    required super.email,
    required super.password,
  }) : super.forLogin();

  // Constructor for authenticated user
  const UserModel.authenticated({
    required super.id,
    required super.email,
    required super.name,
  }) : super.authenticated();

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String?,
      email: json['email'] as String,
      name: json['name'] as String?,
      password: json['password'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'email': email,
      if (name != null) 'name': name,
      if (password != null) 'password': password,
    };
  }
}