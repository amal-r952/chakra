// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    this.statuscode,
    this.statusmessage,
    this.errorcode,
    this.errormessage,
    required this.data,
  });

  final int? statuscode;
  final dynamic statusmessage;
  final int? errorcode;
  final String? errormessage;
  final Data data;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    statuscode: json["statuscode"],
    statusmessage: json["statusmessage"],
    errorcode: json["errorcode"] ,
    errormessage: json["errormessage"],
    data:  Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "statuscode": statuscode ,
    "statusmessage": statusmessage,
    "errorcode": errorcode ,
    "errormessage": errormessage ,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    this.userid,
    this.loginmessage,
    this.maxinactivesession,
    this.profileupdaterequired,
    this.mobileverificationrequired,
    this.emailverificationrequired,
    this.resetpassword,
    this.authtoken,
  });

  final String? userid;
  final dynamic loginmessage;
  final int? maxinactivesession;
  final bool? profileupdaterequired;
  final bool? mobileverificationrequired;
  final bool? emailverificationrequired;
  final bool? resetpassword;
  final String? authtoken;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userid: json["userid"] ,
    loginmessage: json["loginmessage"],
    maxinactivesession: json["maxinactivesession"] ,
    profileupdaterequired: json["profileupdaterequired"] ,
    mobileverificationrequired: json["mobileverificationrequired"],
    emailverificationrequired: json["emailverificationrequired"],
    resetpassword: json["resetpassword"] ,
    authtoken: json["authtoken"],
  );

  Map<String, dynamic> toJson() => {
    "userid": userid ,
    "loginmessage": loginmessage,
    "maxinactivesession": maxinactivesession ,
    "profileupdaterequired": profileupdaterequired ,
    "mobileverificationrequired": mobileverificationrequired ,
    "emailverificationrequired": emailverificationrequired ,
    "resetpassword": resetpassword ,
    "authtoken": authtoken ,
  };
}
