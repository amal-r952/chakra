import 'package:chakra/src/bloc/user_bloc.dart';
import 'package:chakra/src/models/order_response_model.dart';
import 'package:chakra/src/models/product_response_model.dart';
import 'package:chakra/src/models/store_response_model.dart';
import 'package:chakra/src/screens/pick_store_page.dart';
import 'package:chakra/src/utils/app_toasts.dart';
import 'package:chakra/src/utils/utils.dart';
import 'package:chakra/src/widgets/build_home_listing_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/app_colors.dart';
import '../utils/object_factory.dart';
import '../widgets/build_custom_appbar_widget.dart';
import '../widgets/build_elevated_button.dart';
import '../widgets/build_loading_widget.dart';
import '../widgets/build_textfield_with_heading_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static DateTime? _currentBackPressTime;
  final TextEditingController storeController = TextEditingController();
  UserBloc userBloc = UserBloc();
  StoreResponseModel? selectedStore;
  List<ProductResponseModel> products = [];
  List<OrderResponseModel> orders = [];
  double? totalPrice;
  bool isFetchingProducts = false;
  bool isAddingOrders = false;

  @override
  void initState() {
    super.initState();

    print("IS LOGGED IN:${ObjectFactory().appHive.getIsUserLoggedIn()}");
    print("DISTRIBUTOR ID:${ObjectFactory().appHive.getDistributorId()}");
    print("USER ID:${ObjectFactory().appHive.getUserId()}");
    print("USER NAME:${ObjectFactory().appHive.getUserName()}");

    userBloc.getProductsResponse.listen((event) {
      setState(() {
        isFetchingProducts = false;
        products = event;
        orders =
            List.generate(products.length, (index) => OrderResponseModel());
      });
      print("GET PRODUCTS RESPONSE: $event");
    }).onError((error) {
      setState(() {
        isFetchingProducts = false;
      });
      AppToasts.showErrorToastTop(
          context, "Error fetching products, Please try again!");
    });
    userBloc.addOrdersResponse.listen((event) {
      print("ADD ORDERS RESPONSE: $event");
      setState(() {
        isAddingOrders = false;
      });
      products.clear();
      orders.clear();
      selectedStore = null;
      storeController.clear();
      totalPrice = 0;
      AppToasts.showSuccessToastTop(context, "Orders Added Successfully!");
    }).onError((error) {
      setState(() {
        isAddingOrders = false;
      });
      AppToasts.showErrorToastTop(
          context, "Error creating orders, Please try again!");
    });
  }

  onPopScopeTriggered(BuildContext context) {
    DateTime now = DateTime.now();
    if (_currentBackPressTime == null ||
        now.difference(_currentBackPressTime!) > const Duration(seconds: 2)) {
      _currentBackPressTime = now;
      AppToasts.showWarningToastBottom(
          context, "Press back button again to exit!");
    } else {
      SystemNavigator.pop();
    }
  }

  void updateOrder(int index, OrderResponseModel updatedOrder) {
    print("IS UPDATING ORDER DATA");
    setState(() {
      orders[index] = updatedOrder;
    });
  }

  void updateTotalPrice(List<OrderResponseModel> orders) {
    print("IS CALCULATING TOTAL PRICE");
    // Reset the totalPrice before recalculating
    double totalPrice = 0.0;

    // Loop through each order and add the productTotalPrice if valid
    for (OrderResponseModel item in orders) {
      if (item.productTotalPrice != null && item.productTotalPrice != 0) {
        totalPrice += item.productTotalPrice!;
      }
    }

    // After calculating, you can either return the value or update a state variable
    print("Total Price: $totalPrice");
    // If you want to store it in a state variable, set it here
    setState(() {
      this.totalPrice = totalPrice;
    });
  }

  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        onPopScopeTriggered(context);
      },
      child: Scaffold(
        appBar: BuildCustomAppBarWidget(
          centerTitle: false,
          titleText: "New Order",
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text("L/P = List Price"),
              Text("S/P = Scheme Price"),
              GestureDetector(
                onTap: () async {
                  selectedStore = await push(
                    context,
                    PickStorePage(),
                  );

                  if (selectedStore != null) {
                    products.clear();
                    orders.clear();
                    totalPrice = 0;
                    storeController.text = selectedStore!.storeName!;
                    setState(() {
                      isFetchingProducts = true;
                    });
                    userBloc.getProducts();
                  }
                },
                child: BuildTextFieldWithHeadingWidget(
                  textCapitalization: TextCapitalization.none,
                  enable: false,
                  headingSize: 12,
                  styleType: 1,
                  headingWeight: FontWeight.w300,
                  heading: "Store name",
                  controller: storeController,
                  contactHintText: "Choose a store",
                  validation: (value) {},
                  showErrorBorderAlways: false,
                ),
              ),
              SizedBox(height: 15),
              storeController.text.isEmpty
                  ? Expanded(
                      child: Center(
                          child: Text("Choose your store!",
                              style:
                                  Theme.of(context).textTheme.headlineSmall)),
                    )
                  : isFetchingProducts
                      ? Expanded(
                          child: Center(
                              child: CircularProgressIndicator(
                            color: AppColors.mainAccentColor,
                          )),
                        )
                      : products.isEmpty
                          ? Expanded(
                              child: Center(
                                  child: Text("No products to show!",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall)),
                            )
                          : Expanded(
                              child: ListView.builder(
                                itemCount: products.length,
                                itemBuilder: (BuildContext context, int index) {
                                  if (orders.length <= index) {
                                    orders.add(OrderResponseModel());
                                  }

                                  ProductResponseModel product =
                                      products[index];
                                  return BuildHomeListingItemWidget(
                                    storeId: selectedStore!.storeId!,
                                    productResponseModel: products[index],
                                    orderResponseModel: orders[index],
                                    onOrderUpdated:
                                        (OrderResponseModel updatedOrder) {
                                      updateOrder(index, updatedOrder);
                                      updateTotalPrice(orders);
                                      print(updatedOrder.toString());
                                    },
                                  );
                                },
                              ),
                            ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 30),
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "TOTAL: ",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              color: AppColors.mainAccentColor,
                              fontSize: 14, // Adjust size for "TOTAL:"
                            ),
                      ),
                      TextSpan(
                        text: "${(totalPrice ?? 0).toString()}",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              color: AppColors.mainAccentColor,
                              fontSize: 18, // Adjust size for the total price
                            ),
                      ),
                    ],
                  ),
                ),
                BuildElevatedButton(
                  width: screenWidth(context, dividedBy: 2.5),
                  onTap: () async {
                    if (isAddingOrders == false) {
                      setState(() {
                        isAddingOrders = true;
                      });

                      List<OrderResponseModel> validOrders =
                          orders.where((order) {
                        return order.productTotalPrice != null &&
                            order.productTotalPrice != 0 &&
                            order.productQuantity != null &&
                            order.productQuantity != 0;
                      }).toList();

                      if (validOrders.isNotEmpty) {
                        // for (OrderResponseModel order in validOrders) {
                        //   print("ORDER ID: ${order.orderId}");
                        //   print("TOTAL PRICE: ${order.productTotalPrice}");
                        //   print("PRODUCT QUANTITY: ${order.productQuantity}");
                        //   print("STORE ID: ${order.storeId}");
                        //   print("USER ID: ${order.userId}");
                        //   print("DISTRIBUTOR ID: ${order.distributorId}");
                        //   print("CREATED AT: ${order.createdAt}");
                        //   print("PRODUCT ID: ${order.productId}");
                        // }
                        // print("Valid Orders: $validOrders");
                        print("Valid Orders Length: ${validOrders.length}");
                        userBloc.addOrders(orders: validOrders);
                      } else {
                        setState(() {
                          isAddingOrders = false;
                        });
                        AppToasts.showWarningToastBottom(
                            context, "No valid orders to add!");
                      }
                    }
                  },
                  txt: "ADD ORDERS",
                  child: isAddingOrders
                      ? const BuildLoadingWidget(
                          color: AppColors.primaryColorLight,
                        )
                      : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    storeController.dispose();
    super.dispose();
  }
}
