import 'package:flutter/material.dart';

class Constants {
  static final rupeeSymbol = "\u20B9";
  static const String BOX_NAME = "app";

  ///gradients
  static List<Color> kitGradients = [
    Colors.white, //0
    Colors.black, //1
    Colors.grey, //2
    Colors.black54, //3
    const Color(0xFFA38E5D), //4
    const Color(0xFF1977F3), //5
    const Color(0xFFD9D9D9), //6
    const Color(0xFF105AE9), //7
    const Color(0xFFDCDCDC), //8
    Colors.green, //9
  ];

  ///error
  static const String SOME_ERROR_OCCURRED = "Some error occurred.";

  ///dialog
  static const String CANCEL = "Cancel";
  static const String OK = "Ok";
  static const String YES = "Yes";
  static const String CLOSE = "Close";
  static const String UPDATE = "Update";
  static const String ORDER_CANCELLATION = "Confirm order cancellation?";

  ///no internet
  static const String NO_INTERNET_TEXT = "No Internet Connection !!!";
  static const String INTERNET_CONNECTED = "Internet Connected !!!";

  ///validators
  static const String EMAIL_NOT_VALID = "Email is not valid";
  static const String USERNAME_NOT_VALID = "Username is not valid";
  static const String PASSWORD_LENGTH =
      "Password length should be greater than 5 chars.";
  static const String INVALID_MOBILE_NUM = "Invalid mobile number";
  static const String INVALID_NAME = "Invalid name";
}
