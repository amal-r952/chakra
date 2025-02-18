import 'package:chakra/src/utils/app_colors.dart';
import 'package:flutter/material.dart';

import 'build_svg_icon_button.dart';

class BuildCustomAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  final String? action1IconPath;
  final Key? menuKey;
  final String? action2IconPath;
  final String? backButtonIconPath;
  final String? titleText;
  final String? fontFamily;
  final bool centerTitle;
  final Widget? centerWidget;
  final double? action1IconHorizontalPadding;
  final double? action2IconHorizontalPadding;
  final double? action1IconHeight;
  final double? action2IconHeight;
  final double? backButtonIconHeight;
  final Function()? onAction1Pressed;
  final Function()? onAction2Pressed;
  final Function()? onBackButtonPressed;

  BuildCustomAppBarWidget({
    Key? key,
    this.action1IconPath,
    this.centerWidget,
    this.action2IconPath,
    this.backButtonIconPath,
    this.titleText,
    this.centerTitle = false,
    this.action1IconHeight,
    this.action2IconHeight,
    this.backButtonIconHeight,
    this.onAction1Pressed,
    this.onAction2Pressed,
    this.onBackButtonPressed,
    Size? preferredSize,
    this.fontFamily,
    this.menuKey,
    this.action1IconHorizontalPadding,
    this.action2IconHorizontalPadding,
  })  : preferredSize = preferredSize ?? const Size.fromHeight(60.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      actionsIconTheme: Theme.of(context).appBarTheme.actionsIconTheme,
      actions: [
        if (action1IconPath != null)
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: action1IconHorizontalPadding ?? 0),
            child: BuildSvgIconButton(
              key: menuKey,
              assetImagePath: action1IconPath!,
              iconHeight: action1IconHeight ?? 30,
              color: AppColors.mainAccentColor,
              onTap: onAction1Pressed!,
            ),
          ),
        if (action2IconPath != null)
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: action2IconHorizontalPadding ?? 0),
            child: BuildSvgIconButton(
              assetImagePath: action2IconPath!,
              iconHeight: action2IconHeight ?? 20,
              onTap: onAction2Pressed!,
            ),
          ),
      ],
      leading: backButtonIconPath != null
          ? BuildSvgIconButton(
              assetImagePath: backButtonIconPath!,
              color: ThemeMode.system == ThemeMode.dark
                  ? Colors.white
                  : Colors.black,
              iconHeight: backButtonIconHeight ?? 18,
              onTap: onBackButtonPressed!,
            )
          : null,
      title: centerWidget ??
          Text(
            titleText!,
            style: Theme.of(context)
                .textTheme
                .headlineLarge
                ?.copyWith(fontSize: 18, fontWeight: FontWeight.w500),
            textAlign: centerTitle ? TextAlign.center : TextAlign.start,
          ),
      centerTitle: centerTitle,
    );
  }
}
