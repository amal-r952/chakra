import 'package:cloud_firestore/cloud_firestore.dart';

class UserResponseModel {
  String distributorId;
  DateTime lastLogin;
  String role;
  String userId;
  String userName;
  String password;

  UserResponseModel({
    required this.distributorId,
    required this.lastLogin,
    required this.role,
    required this.userId,
    required this.userName,
    required this.password,
  });

  factory UserResponseModel.fromJson(Map<String, dynamic> json) =>
      UserResponseModel(
        distributorId: json["distributor_id"].toString(),
        lastLogin: (json["last_login"] as Timestamp).toDate(),
        role: json["role"],
        userId: json["user_id"],
        userName: json["user_name"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "distributor_id": distributorId,
        "last_login": lastLogin.toIso8601String(),
        "role": role,
        "user_id": userId,
        "user_name": userName,
        "password": password,
      };
}
