import 'package:chakra/src/utils/app_colors.dart';
import 'package:flutter/material.dart';

import '../widget_theme/app_bar_theme.dart';
import '../widget_theme/text_theme.dart';

final ThemeData darkThemeData = ThemeData(
  colorScheme: const ColorScheme.dark(
    primary: AppColors.primaryColorDark,
    secondary: AppColors.accentColorDark,
  ),
  brightness: Brightness.dark,
  scaffoldBackgroundColor: AppColors.scaffoldColorDark,
  textTheme: darkTextTheme,
  appBarTheme: darkAppbarTheme,
);
