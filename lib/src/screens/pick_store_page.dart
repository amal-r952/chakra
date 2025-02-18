import 'package:chakra/src/models/store_response_model.dart';
import 'package:chakra/src/utils/font_family.dart';
import 'package:flutter/material.dart';

import '../bloc/user_bloc.dart';
import '../utils/app_assets.dart';
import '../utils/app_colors.dart';
import '../utils/utils.dart';
import '../widgets/build_custom_appbar_widget.dart';
import '../widgets/build_textfield_widget.dart';

class PickStorePage extends StatefulWidget {
  const PickStorePage({super.key});

  @override
  State<PickStorePage> createState() => _PickStorePageState();
}

class _PickStorePageState extends State<PickStorePage> {
  StoreResponseModel? selectedStore;
  List<StoreResponseModel> stores = [];
  List<StoreResponseModel> filteredStores = [];
  bool isFetchingStores = false;
  UserBloc userBloc = UserBloc();

  TextEditingController searchController = TextEditingController();

  getStores() {
    setState(() {
      isFetchingStores = true;
    });
    userBloc.getStores();
  }

  @override
  void initState() {
    super.initState();
    getStores();
    userBloc.getStoresResponse.listen((event) {
      setState(() {
        isFetchingStores = false;
        stores = event;
        filteredStores = event;
      });
    }).onError((error) {
      setState(() {
        isFetchingStores = false;
      });
    });

    searchController.addListener(() {
      filterStores(searchController.text);
    });
  }

  void filterStores(String query) {
    List<StoreResponseModel> filteredList = stores
        .where((store) =>
            store.storeName!.toLowerCase().contains(query.toLowerCase()))
        .toList();

    setState(() {
      filteredStores = filteredList;
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BuildCustomAppBarWidget(
        centerTitle: false,
        titleText: "Pick Store",
        backButtonIconPath: AppAssets.appbarBackButton,
        onBackButtonPressed: () {
          pop(context);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            BuildTextField(
              textCapitalization: TextCapitalization.none,
              showAlwaysErrorBorder: false,
              textEditingController: searchController,
              obscureText: false,
              showBorder: true,
              maxLines: 1,
              borderRadius: 4,
              hintText: "Search store name here",
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 15),
            isFetchingStores
                ? Expanded(
                    child: Center(
                        child: CircularProgressIndicator(
                      color: AppColors.mainAccentColor,
                    )),
                  )
                : filteredStores.isEmpty
                    ? Expanded(
                        child: Center(
                            child: Text("No stores match your search!",
                                style:
                                    Theme.of(context).textTheme.headlineSmall)),
                      )
                    : Expanded(
                        child: ListView.builder(
                          itemCount: filteredStores.length,
                          itemBuilder: (BuildContext context, int index) {
                            StoreResponseModel store = filteredStores[index];
                            print(store.storeName);
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedStore = store;
                                });
                                Navigator.pop(context, selectedStore);
                              },
                              child: Card(
                                elevation: 2.0,
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                child: ListTile(
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  leading: Icon(
                                    Icons.factory,
                                    color: AppColors.mainAccentColor,
                                  ),
                                  title: Text(store.storeName!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium
                                          ?.copyWith(
                                              fontWeight: FontWeight.w700,
                                              fontFamily: FontFamily.notoSans)),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}
