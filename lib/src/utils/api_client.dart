import 'dart:async';

import 'package:chakra/src/models/login_request_model.dart';
import 'package:chakra/src/utils/urls.dart';
import 'package:dio/dio.dart';

import 'object_factory.dart';

class ApiClient {

  Future<Response> loginRequest(LoginRequest loginRequest) {
    print(loginRequest.toString());

    return ObjectFactory().appDio.post(url: Urls.baseUrl, data: loginRequest);
  }
}
