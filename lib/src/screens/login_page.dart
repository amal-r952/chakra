import 'package:chakra/src/bloc/user_bloc.dart';
import 'package:chakra/src/utils/app_toasts.dart';
import 'package:chakra/src/utils/utils.dart';
import 'package:flutter/material.dart';

import '../utils/app_assets.dart';
import '../utils/app_colors.dart';
import '../utils/font_family.dart';
import '../utils/object_factory.dart';
import '../widgets/build_bottom_nav_bar.dart';
import '../widgets/build_elevated_button.dart';
import '../widgets/build_loading_widget.dart';
import '../widgets/build_svg_icon_button.dart';
import '../widgets/build_textfield_widget.dart';
import '../widgets/build_textfield_with_heading_widget.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController userIdController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController distributorCodeController = TextEditingController();
  UserBloc userBloc = UserBloc();
  bool isObscure = true;
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    userBloc.loginResponse.listen((event) {
      print("LOGIN RESPONSE: $event");
      setState(() {
        isLoading = false;
      });
      AppToasts.showSuccessToastTop(context, "Logged in successfully!");
      ObjectFactory().appHive.putIsUserLoggedIn(isLoggedIn: true);
      ObjectFactory()
          .appHive
          .putDistributorId(distributorId: event.distributorId);
      ObjectFactory().appHive.putUserName(userName: event.userName);
      ObjectFactory().appHive.putUserId(userId: event.userId);
      push(context, const BuildBottomNavBar());
    }).onError((error) {
      print("LOGIN ERROR: $error");
      setState(() {
        isLoading = false;
      });
      AppToasts.showErrorToastTop(context, "Login failed!, Please try again");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColourInAuthScreens,
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight(context, dividedBy: 5)),
                BuildTextFieldWithHeadingWidget(
                  textCapitalization: TextCapitalization.none,
                  headingSize: 12,
                  styleType: 1,
                  headingWeight: FontWeight.w300,
                  heading: "User ID",
                  controller: userIdController,
                  contactHintText: "Enter the user id",
                  validation: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the user ID to proceed!";
                    }
                    return null;
                  },
                  showErrorBorderAlways: false,
                ),
                SizedBox(height: screenHeight(context, dividedBy: 20)),
                BuildTextFieldWithHeadingWidget(
                  textCapitalization: TextCapitalization.none,
                  headingSize: 12,
                  styleType: 1,
                  headingWeight: FontWeight.w300,
                  heading: "Distributor Code",
                  controller: distributorCodeController,
                  contactHintText: "Enter the distributor code",
                  validation: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the distributor code to proceed!";
                    }
                    return null;
                  },
                  showErrorBorderAlways: false,
                ),
                SizedBox(height: screenHeight(context, dividedBy: 20)),
                Text(
                  " Password",
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                        fontFamily: FontFamily.gothamBook,
                      ),
                ),
                const SizedBox(height: 8),
                BuildTextField(
                  textCapitalization: TextCapitalization.none,
                  showAlwaysErrorBorder: false,
                  textEditingController: passwordController,
                  obscureText: isObscure,
                  showBorder: true,
                  maxLines: 1,
                  borderRadius: 4,
                  hintText: "Enter the password",
                  keyboardType: TextInputType.text,
                  suffixIcon: BuildSvgIconButton(
                    assetImagePath: isObscure
                        ? AppAssets.passwordHideIcon
                        : AppAssets.passwordShowIcon,
                    onTap: () {
                      setState(() {
                        isObscure = !isObscure;
                      });
                    },
                    iconHeight: 18,
                  ),
                  validation: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter a password to proceed!";
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: BuildElevatedButton(
          onTap: () async {
            if (isLoading == false) {
              if (formKey.currentState!.validate()) {
                setState(() {
                  isLoading = true;
                });
                userBloc.login(
                    userId: userIdController.text,
                    distributorCode: distributorCodeController.text,
                    password: passwordController.text);
              }
            }
          },
          txt: "LOGIN",
          child: isLoading
              ? const BuildLoadingWidget(
                  color: AppColors.primaryColorLight,
                )
              : null,
        ),
      ),
    );
  }

  @override
  void dispose() {
    userIdController.dispose();
    passwordController.dispose();
    distributorCodeController.dispose();
    super.dispose();
  }
}
