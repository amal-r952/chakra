import 'dart:convert';

import 'package:chakra/src/models/store_response_model.dart';
import 'package:chakra/src/models/user_response_model.dart';
import 'package:chakra/src/utils/object_factory.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';

import '../models/order_response_model.dart';
import '../models/product_response_model.dart';

class FirebaseServices {
  Future<UserResponseModel?> login({
    required String userId,
    required String distributorCode,
    required String password,
  }) async {
    try {
      final String hashedPassword;
      String hashPassword(String password) {
        var bytes = utf8.encode(password);
        var hashedPassword = sha256.convert(bytes);
        return hashedPassword.toString();
      }

      hashedPassword = await hashPassword(password);
      print("HASHED PASSWORD: $hashedPassword");
      CollectionReference usersCollection =
          FirebaseFirestore.instance.collection('users');

      QuerySnapshot querySnapshot = await usersCollection
          .where('user_id', isEqualTo: userId)
          .where('distributor_id', isEqualTo: distributorCode)
          .where('password', isEqualTo: hashedPassword)
          .limit(1)
          .get();
      for (var doc in querySnapshot.docs) {
        print(doc.data());
      }
      if (querySnapshot.docs.isNotEmpty) {
        Map<String, dynamic> userData =
            querySnapshot.docs.first.data() as Map<String, dynamic>;
        return UserResponseModel.fromJson(userData);
      } else {
        return null;
      }
    } catch (e) {
      print('Error during login: $e');
      return null;
    }
  }

  Future<List<ProductResponseModel>?> getProducts() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('products')
          .where("distributor_code",
              isEqualTo: ObjectFactory().appHive.getDistributorId())
          .orderBy('priority_order', descending: false)
          .get();

      List<ProductResponseModel> products = snapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        return ProductResponseModel.fromJson(data);
      }).toList();

      return products;
    } catch (e) {
      print("Error getting products: $e");
      return null;
    }
  }

  Future<List<StoreResponseModel>?> getStores() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('stores')
          .where("distributor_id",
              isEqualTo: ObjectFactory().appHive.getDistributorId())
          // .where("user_id", isEqualTo: ObjectFactory().appHive.getUserId())
          .get();

      List<StoreResponseModel> stores = snapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        return StoreResponseModel.fromJson(data);
      }).toList();

      return stores;
    } catch (e) {
      print("Error getting products: $e");
      return null;
    }
  }

  Future<String> addOrders({required List<OrderResponseModel> orders}) async {
    try {
      // Iterate over the list of orders
      for (OrderResponseModel order in orders) {
        // Create a Map to store order data
        Map<String, dynamic> orderData = {
          'order_id': order.orderId,
          'user_id': order.userId,
          'created_at': order.createdAt,
          'distributor_id': order.distributorId,
          'store_id': order.storeId,
          'product_id': order.productId,
          'product_quantity': order.productQuantity,
          'product_total_price': order.productTotalPrice,
          'product_alias': order.productAlias,
        };

        // Add the order document to the 'orders' collection
        await FirebaseFirestore.instance.collection('orders').add(orderData);
      }

      // If the loop completes without any errors, return success
      return "success";
    } catch (e) {
      print("Error adding orders: $e");
      // If an error occurs, return failed
      return "failed";
    }
  }

  Future<List<OrderResponseModel>> getOrders(
      {required DateTime startDate,
      required DateTime endDate,
      required String storeId}) async {
    try {
      String? distributorId = ObjectFactory().appHive.getDistributorId();
      String? userId = ObjectFactory().appHive.getUserId();

      // Convert to UTC
      Timestamp startTimestamp = Timestamp.fromDate(startDate.toUtc());
      Timestamp endTimestamp = Timestamp.fromDate(endDate.toUtc());

      print("START TIME STAMP: $startTimestamp");
      print("END TIME STAMP: $endTimestamp");
      print("DISTRIBUTOR ID: $distributorId");

      // Adjust end date to include the entire day if necessary
      endDate = DateTime(endDate.year, endDate.month, endDate.day, 23, 59, 59);
      endTimestamp = Timestamp.fromDate(endDate.toUtc());

      // Query Firestore to fetch orders based on the date range and distributor
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('orders')
          .where('created_at', isGreaterThanOrEqualTo: startTimestamp)
          .where('created_at', isLessThanOrEqualTo: endTimestamp)
          .where('distributor_id', isEqualTo: distributorId)
          .where('store_id', isEqualTo: storeId)
          .where('user_id', isEqualTo: userId)
          .get();

      // Convert the fetched documents into a list of OrderResponseModel
      List<OrderResponseModel> orders = snapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        return OrderResponseModel.fromJson(data);
      }).toList();

      // Return the list of orders
      return orders;
    } catch (e) {
      print("Error fetching orders: $e");
      return [];
    }
  }

  Future<List<OrderResponseModel>> getAllOrders({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      String? distributorId = ObjectFactory().appHive.getDistributorId();
      String? userId = ObjectFactory().appHive.getUserId();
      Timestamp startTimestamp = Timestamp.fromDate(startDate.toUtc());
      Timestamp endTimestamp = Timestamp.fromDate(endDate.toUtc());

      print("START TIME STAMP: $startTimestamp");
      print("END TIME STAMP: $endTimestamp");
      print("DISTRIBUTOR ID: $distributorId");

      // Adjust end date to include the entire day if necessary
      endDate = DateTime(endDate.year, endDate.month, endDate.day, 23, 59, 59);
      endTimestamp = Timestamp.fromDate(endDate.toUtc());

      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('orders')
          .where('created_at', isGreaterThanOrEqualTo: startTimestamp)
          .where('created_at', isLessThanOrEqualTo: endTimestamp)
          .where('distributor_id', isEqualTo: distributorId)
          .where('user_id', isEqualTo: userId)
          .get();

      // Convert the fetched documents into a list of OrderResponseModel
      List<OrderResponseModel> orders = snapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        return OrderResponseModel.fromJson(data);
      }).toList();

      // Return the list of orders
      return orders;
    } catch (e) {
      print("Error fetching orders: $e");
      return [];
    }
  }
}
