import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/constants.dart';

class BuildBottomBarIcons extends StatelessWidget {
  final String assetImagePath;
  final int index;
  final int selectedIndex;
  final double? width;
  final double? height;
  const BuildBottomBarIcons(
      {Key? key,
      required this.assetImagePath,
      required this.index,
      this.width,
      this.height,
      required this.selectedIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SvgPicture.asset(
        assetImagePath,
        colorFilter: selectedIndex == index
            ? const ColorFilter.mode(Colors.black, BlendMode.srcIn)
            : ColorFilter.mode(Constants.kitGradients[6], BlendMode.srcIn),
        width: width ?? 20,
        height: height ?? 20,
        fit: BoxFit.cover,
      ),
    );
  }
}
