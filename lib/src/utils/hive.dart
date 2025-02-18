import 'package:hive/hive.dart';

import 'constants.dart';

class AppHive {
  static const String _TOKEN = "token";
  static const String _ISLOGGEDIN = "isLoggedIn";
  static const String _BASEURL = "baseUrl";
  static const String _DISTRIBUTOR_ID = "distributorId";
  static const String _USER_NAME = "userName";
  static const String _USER_ID = "userId";

  void hivePut({String? key, String? value}) async {
    await Hive.box(Constants.BOX_NAME).put(key, value);
  }

  String hiveGet({String? key}) {
    // openBox();
    return Hive.box(Constants.BOX_NAME).get(key);
  }

  putToken({String? token}) {
    hivePut(key: _TOKEN, value: token);
  }

  String getToken() {
    return hiveGet(key: _TOKEN);
  }

  Future<void> putIsUserLoggedIn({required bool isLoggedIn}) async {
    await Hive.box(Constants.BOX_NAME).put(
      _ISLOGGEDIN,
      isLoggedIn,
    );
  }

  bool? getIsUserLoggedIn() {
    return Hive.box(Constants.BOX_NAME).get(_ISLOGGEDIN);
  }

  Future<void> putBaseUrl({required String baseUrl}) async {
    await Hive.box(Constants.BOX_NAME).put(
      _BASEURL,
      baseUrl,
    );
  }

  String? getBaseUrl() {
    var box = Hive.box(Constants.BOX_NAME);
    return box.get(_BASEURL);
  }

  Future<void> putDistributorId({required String distributorId}) async {
    await Hive.box(Constants.BOX_NAME).put(
      _DISTRIBUTOR_ID,
      distributorId,
    );
  }

  String? getDistributorId() {
    var box = Hive.box(Constants.BOX_NAME);
    return box.get(_DISTRIBUTOR_ID);
  }

  Future<void> putUserName({required String userName}) async {
    await Hive.box(Constants.BOX_NAME).put(
      _USER_NAME,
      userName,
    );
  }

  String? getUserName() {
    var box = Hive.box(Constants.BOX_NAME);
    return box.get(_USER_NAME);
  }

  Future<void> putUserId({required String userId}) async {
    await Hive.box(Constants.BOX_NAME).put(
      _USER_ID,
      userId,
    );
  }

  String? getUserId() {
    var box = Hive.box(Constants.BOX_NAME);
    return box.get(_USER_ID);
  }

  clearBox() {
    Hive.box(Constants.BOX_NAME).clear();
  }

  AppHive();
}
