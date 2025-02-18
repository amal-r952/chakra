import 'package:chakra/src/utils/app_colors.dart';
import 'package:flutter/material.dart';

import '../widget_theme/app_bar_theme.dart';
import '../widget_theme/text_theme.dart';

final ThemeData lightThemeData = ThemeData(
  colorScheme: const ColorScheme.light(
    primary: AppColors.primaryColorLight,
    secondary: AppColors.accentColorLight,
  ),
  brightness: Brightness.light,
  scaffoldBackgroundColor: AppColors.scaffoldBackgroundColourInAuthScreens,
  textTheme: lightTextTheme,
  appBarTheme: lightAppBarTheme,
  // actionIconTheme:
);
