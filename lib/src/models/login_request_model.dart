// To parse this JSON data, do
//
//     final loginRequest = loginRequestFromJson(jsonString);

import 'dart:convert';

LoginRequest loginRequestFromJson(String str) => LoginRequest.fromJson(json.decode(str));

String loginRequestToJson(LoginRequest data) => json.encode(data.toJson());

class LoginRequest {
  LoginRequest({
    required this.password,
    required this.username,
  });

  final String password;
  final String username;

  factory LoginRequest.fromJson(Map<String, dynamic> json) => LoginRequest(
    password: json["password"],
    username: json["username"],
  );

  Map<String, dynamic> toJson() => {
    "password": password ,
    "username": username ,
  };
}
