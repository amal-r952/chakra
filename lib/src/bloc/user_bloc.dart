import 'dart:async';

import 'package:chakra/src/models/order_response_model.dart';
import 'package:chakra/src/models/store_response_model.dart';
import 'package:chakra/src/models/user_response_model.dart';

import '../models/product_response_model.dart';
import '../models/state.dart';
import '../utils/object_factory.dart';
import '../utils/validators.dart';
import 'base_bloc.dart';

/// stream data is handled by StreamControllers

class UserBloc extends Object with Validators implements BaseBloc {
  final StreamController<bool> _loading = StreamController<bool>.broadcast();

  final StreamController<UserResponseModel> _login =
      StreamController<UserResponseModel>.broadcast();
  final StreamController<List<ProductResponseModel>> _getProducts =
      StreamController<List<ProductResponseModel>>.broadcast();
  final StreamController<List<StoreResponseModel>> _getStores =
      StreamController<List<StoreResponseModel>>.broadcast();
  final StreamController<String> _addOrders =
      StreamController<String>.broadcast();
  final StreamController<List<OrderResponseModel>> _getOrders =
      StreamController<List<OrderResponseModel>>.broadcast();
  final StreamController<List<OrderResponseModel>> _getAllOrders =
      StreamController<List<OrderResponseModel>>.broadcast();

  Stream<bool> get loadingListener => _loading.stream;

  Stream<UserResponseModel> get loginResponse => _login.stream;
  Stream<List<ProductResponseModel>> get getProductsResponse =>
      _getProducts.stream;
  Stream<List<StoreResponseModel>> get getStoresResponse => _getStores.stream;
  Stream<String> get addOrdersResponse => _addOrders.stream;
  Stream<List<OrderResponseModel>> get getOrdersResponse => _getOrders.stream;
  Stream<List<OrderResponseModel>> get getAllOrdersResponse =>
      _getAllOrders.stream;

  StreamSink<bool> get loadingSink => _loading.sink;

  StreamSink<UserResponseModel> get loginSink => _login.sink;
  StreamSink<List<ProductResponseModel>> get getProductsSink =>
      _getProducts.sink;
  StreamSink<List<StoreResponseModel>> get getStoresSink => _getStores.sink;
  StreamSink<String> get addOrdersSink => _addOrders.sink;
  StreamSink<List<OrderResponseModel>> get getOrdersSink => _getOrders.sink;
  StreamSink<List<OrderResponseModel>> get getAllOrdersSink =>
      _getAllOrders.sink;

  login(
      {required String userId,
      required String distributorCode,
      required String password}) async {
    loadingSink.add(true);

    State? state = await ObjectFactory().repository.login(
          userId: userId,
          distributorCode: distributorCode,
          password: password,
        );

    if (state is SuccessState) {
      loadingSink.add(false);
      _login.sink.add(state.value);
    } else if (state is ErrorState) {
      loadingSink.add(false);
      _login.sink.addError(state.msg);
    }
  }

  getProducts() async {
    loadingSink.add(true);

    State? state = await ObjectFactory().repository.getProducts();

    if (state is SuccessState) {
      loadingSink.add(false);
      _getProducts.sink.add(state.value);
    } else if (state is ErrorState) {
      loadingSink.add(false);
      _getProducts.sink.addError(state.msg);
    }
  }

  getStores() async {
    loadingSink.add(true);

    State? state = await ObjectFactory().repository.getStores();

    if (state is SuccessState) {
      loadingSink.add(false);
      _getStores.sink.add(state.value);
    } else if (state is ErrorState) {
      loadingSink.add(false);
      _getStores.sink.addError(state.msg);
    }
  }

  addOrders({required List<OrderResponseModel> orders}) async {
    loadingSink.add(true);

    State? state = await ObjectFactory().repository.addOrders(orders: orders);

    if (state is SuccessState) {
      loadingSink.add(false);
      _addOrders.sink.add(state.value);
    } else if (state is ErrorState) {
      loadingSink.add(false);
      _addOrders.sink.addError(state.msg);
    }
  }

  getOrders({
    required DateTime startDate,
    required DateTime endDate,
    required String storeId,
  }) async {
    loadingSink.add(true);

    State? state = await ObjectFactory().repository.getOrders(
          startDate: startDate,
          endDate: endDate,
          storeId: storeId,
        );

    if (state is SuccessState) {
      loadingSink.add(false);
      _getOrders.sink.add(state.value);
    } else if (state is ErrorState) {
      loadingSink.add(false);
      _getOrders.sink.addError(state.msg);
    }
  }

  getAllOrders({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    loadingSink.add(true);

    State? state = await ObjectFactory()
        .repository
        .getAllOrders(startDate: startDate, endDate: endDate);

    if (state is SuccessState) {
      loadingSink.add(false);
      _getAllOrders.sink.add(state.value);
    } else if (state is ErrorState) {
      loadingSink.add(false);
      _getAllOrders.sink.addError(state.msg);
    }
  }

  @override
  void dispose() {
    _loading.close();
    _login.close();
    _getProducts.close();
    _getStores.close();
    _addOrders.close();
    _getOrders.close();
    _getAllOrders.close();
  }
}
