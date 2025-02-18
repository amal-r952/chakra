import 'package:chakra/src/screens/login_page.dart';
import 'package:chakra/src/utils/object_factory.dart';
import 'package:chakra/src/widgets/build_bottom_nav_bar.dart';
import 'package:flutter/material.dart';

import '../utils/app_assets.dart';
import '../utils/app_colors.dart';
import '../utils/utils.dart';
import '../widgets/build_svg_icon.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  void initState() {
    Future.delayed(const Duration(seconds: 2)).then((_) async {
      ObjectFactory().appHive.getIsUserLoggedIn() == true
          ? pushAndRemoveUntil(context, BuildBottomNavBar(), false)
          : pushAndRemoveUntil(context, LoginPage(), false);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: screenWidth(context),
        height: screenHeight(context),
        color: AppColors.primaryColorDark,
        child: Column(
          children: [
            const Spacer(),
            BuildSvgIcon(
              assetImagePath: AppAssets.appIcon,
              iconHeight: screenHeight(
                context,
                dividedBy: 5,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
