import 'package:chakra/src/bloc/user_bloc.dart';
import 'package:chakra/src/models/order_response_model.dart';
import 'package:chakra/src/screens/pick_store_page.dart';
import 'package:chakra/src/utils/utils.dart';
import 'package:chakra/src/widgets/build_calender_days_range_picker.dart';
import 'package:chakra/src/widgets/build_custom_appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/store_response_model.dart';
import '../utils/app_assets.dart';
import '../utils/app_colors.dart';
import '../utils/app_toasts.dart';
import '../utils/object_factory.dart';
import '../widgets/build_action_alert_widget.dart';
import '../widgets/build_elevated_button.dart';
import '../widgets/build_loading_widget.dart';
import '../widgets/build_orders_page_item_widget.dart';
import '../widgets/build_textfield_with_heading_widget.dart';
import 'login_page.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

enum StoreSelectionMode { allStores, selectedStore }

class _OrdersPageState extends State<OrdersPage> {
  static DateTime? _currentBackPressTime;
  TextEditingController storeController = TextEditingController();
  StoreResponseModel? selectedStore;
  List<OrderResponseModel> orders = [];
  bool isFetchingOrders = false;
  DateTime? startDate;
  DateTime? endDate;
  UserBloc userBloc = UserBloc();
  StoreSelectionMode selectedStoreMode = StoreSelectionMode.selectedStore;

  @override
  void initState() {
    userBloc.getAllOrdersResponse.listen((event) {
      // print("EVENT:$event");
      setState(() {
        isFetchingOrders = false;
        orders = event;
      });
    }).onError((error) {
      print("Error fetching all orders: $error");
      setState(() {
        isFetchingOrders = false;
      });
    });
    userBloc.getOrdersResponse.listen((event) {
      setState(() {
        isFetchingOrders = false;
        orders = event;
      });
    }).onError((error) {
      setState(() {
        isFetchingOrders = false;
      });
    });
    super.initState();
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

  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        onPopScopeTriggered(context);
      },
      child: Scaffold(
        appBar: BuildCustomAppBarWidget(
          centerTitle: false,
          titleText: "Orders",
          action1IconPath: AppAssets.logoutIcon,
          onAction1Pressed: () {
            if (!isFetchingOrders) {
              _showLogoutDialogue(context);
            }
          },
          action1IconHeight: 22,
          action1IconHorizontalPadding: 10,
        ),
        body: Column(
          children: [
            // Radio Buttons for Selection Mode
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: RadioListTile<StoreSelectionMode>(
                      activeColor: AppColors.mainAccentColor,
                      title: const Text("All Stores"),
                      value: StoreSelectionMode.allStores,
                      groupValue: selectedStoreMode,
                      onChanged: (value) {
                        setState(() {
                          selectedStoreMode = value!;
                          selectedStore = null; // Reset selected store
                          storeController.clear();
                          orders.clear();
                          startDate = null;
                          endDate = null;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<StoreSelectionMode>(
                      activeColor: AppColors.mainAccentColor,
                      title: const Text("Selected Store"),
                      value: StoreSelectionMode.selectedStore,
                      groupValue: selectedStoreMode,
                      onChanged: (value) {
                        setState(() {
                          selectedStoreMode = value!;
                          orders.clear();
                          startDate = null;
                          endDate = null;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Store Picker (Visible only for Selected Store Mode)
            if (selectedStoreMode == StoreSelectionMode.selectedStore)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: GestureDetector(
                  onTap: () async {
                    selectedStore = await push(
                      context,
                      PickStorePage(),
                    );

                    if (selectedStore != null) {
                      setState(() {
                        orders.clear();
                        startDate = null;
                        endDate = null;
                        storeController.text = selectedStore!.storeName!;
                      });
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
              ),

            // Date Picker Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: BuildElevatedButton(
                onTap: () async {
                  if (!isFetchingOrders) {
                    _showCalendarDialog(context);
                  }
                },
                txt: "Select day(s)",
                child: isFetchingOrders
                    ? const BuildLoadingWidget(
                        color: AppColors.primaryColorLight,
                      )
                    : null,
              ),
            ),

            // Display Selected Dates
            if (startDate != null && endDate != null)
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                child: Text(
                  startDate == endDate
                      ? "Selected Date: ${formatDate(startDate!)}"
                      : "Selected Range: ${formatDate(startDate!)} to ${formatDate(endDate!)}",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),

            // Orders List or Center Message
            if (orders.isEmpty)
              Expanded(
                child: Center(
                  child: Text(
                    _getCenterMessage(),
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            else
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: "Total Orders: ",
                      style: Theme.of(context).textTheme.headlineSmall,
                      children: [
                        TextSpan(
                          text: "${orders.length}",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  RichText(
                    text: TextSpan(
                      text: "Total Price: ",
                      style: Theme.of(context).textTheme.headlineSmall,
                      children: [
                        TextSpan(
                          text:
                              "${orders.fold(0, (sum, order) => sum + order.productTotalPrice!.toInt()).toStringAsFixed(2)}",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            Expanded(
              child: ListView.builder(
                itemCount: orders.length,
                itemBuilder: (BuildContext context, int index) {
                  return BuildOrdersPageItemWidget(order: orders[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getCenterMessage() {
    if (selectedStoreMode == StoreSelectionMode.selectedStore &&
        selectedStore == null) {
      return "Choose a store to view orders!";
    } else if (startDate == null || endDate == null) {
      return "Choose the dates you want to see orders of!";
    } else if (orders.isEmpty) {
      return "You don't have any orders on these days!";
    }
    return "";
  }

  void _showCalendarDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 500,
            child: BuildCalenderDaysRangePicker(
              onRangeSelected: (value) {
                setState(() {
                  startDate = value.start;
                  endDate = value.end;
                  isFetchingOrders = true;
                });
                orders.clear();
                if (selectedStoreMode == StoreSelectionMode.allStores) {
                  userBloc.getAllOrders(
                    startDate: startDate!,
                    endDate: endDate!,
                  );
                } else if (selectedStore != null) {
                  userBloc.getOrders(
                    startDate: startDate!,
                    endDate: endDate!,
                    storeId: selectedStore!.storeId!,
                  );
                }
              },
            ),
          ),
        );
      },
    );
  }

  void _showLogoutDialogue(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: SizedBox(
            width: screenWidth(context),
            height: 250,
            child: BuildActionAlertWidget(
              titleText: "Are you sure you want to logout?",
              primaryButtonText: "Logout",
              secondaryButtonText: "Cancel",
              onPrimaryButtonTap: () async {
                await ObjectFactory().appHive.clearBox();
                pushAndRemoveUntil(context, LoginPage(), false);
              },
              onSecondaryButtonTap: () {
                pop(context);
              },
            ),
          ),
        );
      },
    );
  }
}
