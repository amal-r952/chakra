import 'package:chakra/src/resources/repository/repository.dart';

import 'api_client.dart';
import 'dio.dart';
import 'firebase_client.dart';
import 'hive.dart';

/// it is a hub that connecting pref,repo,client
/// used to reduce imports in pages
class ObjectFactory {
  static final _objectFactory = ObjectFactory._internal();

  ObjectFactory._internal();

  factory ObjectFactory() => _objectFactory;

  ///Initialisation of Objects
  AppHive _appHive = AppHive();
  ApiClient _apiClient = ApiClient();
  FirebaseClient _firebaseClient = FirebaseClient();
  AppDio _appDio = AppDio();
  Repository _repository = Repository();

  ///
  /// Getters of Objects
  ///
  ApiClient get apiClient => _apiClient;
  AppDio get appDio => _appDio;
  FirebaseClient get firebaseClient => _firebaseClient;
  AppHive get appHive => _appHive;
  Repository get repository => _repository;
}
