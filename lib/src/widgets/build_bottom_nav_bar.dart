import 'package:chakra/src/screens/home_page.dart';
import 'package:chakra/src/screens/orders_page.dart';
import 'package:chakra/src/utils/app_assets.dart';
import 'package:chakra/src/utils/app_colors.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../utils/constants.dart';
import 'build_bottom_bar_icons.dart';

class BuildBottomNavBar extends StatefulWidget {
  final int bottomBarIndex;
  const BuildBottomNavBar({
    Key? key,
    this.bottomBarIndex = 0,
  }) : super(key: key);

  @override
  _BuildBottomNavBarState createState() => _BuildBottomNavBarState();
}

class _BuildBottomNavBarState extends State<BuildBottomNavBar> {
  List<Widget> pages = <Widget>[
    const HomePage(),
    const OrdersPage(),
  ];
  late int _selectedIndex = widget.bottomBarIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: CurvedNavigationBar(
        height: 55,
        items: [
          BuildBottomBarIcons(
            assetImagePath: AppAssets.homeIcon,
            index: 0,
            height: 25,
            selectedIndex: _selectedIndex,
          ),
          BuildBottomBarIcons(
            assetImagePath: AppAssets.ordersIcon,
            index: 1,
            height: 25,
            selectedIndex: _selectedIndex,
          ),
        ],
        index: _selectedIndex,
        backgroundColor: Colors.transparent,
        color: AppColors.mainAccentColor,
        buttonBackgroundColor: Constants.kitGradients[6],
        onTap: (int index) => setState(() {
          _selectedIndex = index;
        }),
      ),
    );
  }
}
