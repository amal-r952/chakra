import 'package:chakra/src/models/order_response_model.dart';
import 'package:chakra/src/models/state.dart';
import 'package:chakra/src/resources/api_providers/user_api_provider.dart';
import 'package:chakra/src/resources/firebase_providers/user_firebase_provider.dart';

/// Repository is an intermediary class between network and data
class Repository {
  final userApiProvider = UserApiProvider();
  final userFirebaseProvider = UserFirebaseProvider();

  Future<State?> login(
          {required String userId,
          required String distributorCode,
          required String password}) =>
      userFirebaseProvider.login(
        userId: userId,
        distributorCode: distributorCode,
        password: password,
      );

  Future<State?> getProducts() => userFirebaseProvider.getProducts();
  Future<State?> getStores() => userFirebaseProvider.getStores();
  Future<State?> addOrders({required List<OrderResponseModel> orders}) =>
      userFirebaseProvider.addOrders(orders: orders);
  Future<State?> getOrders(
          {required DateTime startDate,
          required DateTime endDate,
          required String storeId}) =>
      userFirebaseProvider.getOrders(
        startDate: startDate,
        endDate: endDate,
        storeId: storeId,
      );
  Future<State?> getAllOrders({
    required DateTime startDate,
    required DateTime endDate,
  }) =>
      userFirebaseProvider.getAllOrders(startDate: startDate, endDate: endDate);
}
