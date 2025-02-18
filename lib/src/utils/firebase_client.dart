import 'package:chakra/src/models/store_response_model.dart';
import 'package:chakra/src/models/user_response_model.dart';

import '../models/order_response_model.dart';
import '../models/product_response_model.dart';
import '../services/firebase_services.dart';

class FirebaseClient {
  Future<UserResponseModel?> login(
      {required String userId,
      required String distributorCode,
      required String password}) {
    return FirebaseServices().login(
      userId: userId,
      distributorCode: distributorCode,
      password: password,
    );
  }

  Future<List<ProductResponseModel>?> getProducts() {
    return FirebaseServices().getProducts();
  }

  Future<List<StoreResponseModel>?> getStores() {
    return FirebaseServices().getStores();
  }

  Future<String?> addOrders({required List<OrderResponseModel> orders}) {
    return FirebaseServices().addOrders(orders: orders);
  }

  Future<List<OrderResponseModel>?> getOrders(
      {required DateTime startDate,
      required DateTime endDate,
      required String storeId}) {
    return FirebaseServices()
        .getOrders(startDate: startDate, endDate: endDate, storeId: storeId);
  }

  Future<List<OrderResponseModel>?> getAllOrders({
    required DateTime startDate,
    required DateTime endDate,
  }) {
    return FirebaseServices()
        .getAllOrders(startDate: startDate, endDate: endDate);
  }
}
