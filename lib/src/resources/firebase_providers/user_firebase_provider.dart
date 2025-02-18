import 'package:chakra/src/models/state.dart';
import 'package:chakra/src/utils/constants.dart';

import '../../models/order_response_model.dart';
import '../../utils/object_factory.dart';

class UserFirebaseProvider {
  Future<State?> login(
      {required String userId,
      required String distributorCode,
      required String password}) async {
    final data = await ObjectFactory().firebaseClient.login(
        userId: userId, distributorCode: distributorCode, password: password);
    if (data != null) {
      return State.success(data);
    } else {
      return State.error(Constants.SOME_ERROR_OCCURRED);
    }
  }

  Future<State?> getProducts() async {
    final data = await ObjectFactory().firebaseClient.getProducts();
    if (data != null) {
      return State.success(data);
    } else {
      return State.error(Constants.SOME_ERROR_OCCURRED);
    }
  }

  Future<State?> getStores() async {
    final data = await ObjectFactory().firebaseClient.getStores();
    if (data != null) {
      return State.success(data);
    } else {
      return State.error(Constants.SOME_ERROR_OCCURRED);
    }
  }

  Future<State?> addOrders({required List<OrderResponseModel> orders}) async {
    final data = await ObjectFactory().firebaseClient.addOrders(orders: orders);
    if (data != null) {
      return State.success(data);
    } else {
      return State.error(Constants.SOME_ERROR_OCCURRED);
    }
  }

  Future<State?> getOrders(
      {required DateTime startDate,
      required DateTime endDate,
      required String storeId}) async {
    final data = await ObjectFactory()
        .firebaseClient
        .getOrders(startDate: startDate, endDate: endDate, storeId: storeId);
    if (data != null) {
      return State.success(data);
    } else {
      return State.error(Constants.SOME_ERROR_OCCURRED);
    }
  }

  Future<State?> getAllOrders({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final data = await ObjectFactory()
        .firebaseClient
        .getAllOrders(startDate: startDate, endDate: endDate);
    if (data != null) {
      return State.success(data);
    } else {
      return State.error(Constants.SOME_ERROR_OCCURRED);
    }
  }
}
